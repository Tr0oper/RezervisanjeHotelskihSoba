
package RepoPattern;

import Controllers.BrisanjeRezervacije;
import DAO.RezervacijaDAO;
import Models.Datumi;
import Models.Rezervacija;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Pavle
 */
public class RezervacijaRepo implements RezervacijaDAO{
    
    Connection con;
    String url = "jdbc:mysql://localhost:3306/sobehotela";
    String user = "root";
    String pass = "";
    
    public RezervacijaRepo() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } 
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(HotelRepo.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    @Override
    public ArrayList<Rezervacija> lista() throws SQLException{
        
        ArrayList<Rezervacija> rezervacije = new ArrayList<Rezervacija>();
        
        try {
            
             String select = "select r.Id, r.DatumDolaska, r.DatumOdlaska, r.Novac, r.BrojOdraslih, r.BrojDece, r.SobaID, "
                            + " r.KlijentID, r.VremeOdlaska, r.StatusRezervacije, s.BrojSobe as 'BrojSobe', h.Naziv as 'NazivHotela',"
                            + "k.Ime as 'ime', k.Prezime as 'prezime', r.Poeni as 'Poeni' "
                            + " from rezervacije r join sobe s on r.sobaId = s.Id join korisnici k on r.KlijentId = k.Id"
                            + " join hotel h on h.id = s.hotelID";
             
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(select);
             
             while(rs.next()){
                Rezervacija rezervacija = new Rezervacija();
                rezervacija.setId(rs.getInt("Id"));
                rezervacija.setDatumDolaska(rs.getString("DatumDolaska"));
                rezervacija.setDatumOdlaska(rs.getString("DatumOdlaska"));
                rezervacija.setNovac(rs.getDouble("Novac"));
                rezervacija.setBrojOdraslih(rs.getInt("BrojOdraslih"));
                rezervacija.setBrojDece(rs.getInt("BrojDece"));
                rezervacija.setSobaID(rs.getInt("SobaID"));
                rezervacija.setKorisnikId(rs.getInt("KlijentID"));
                rezervacija.setVremeOdlaska(rs.getString("VremeOdlaska"));
                rezervacija.setStatusRezervacije(rs.getBoolean("StatusRezervacije"));
                rezervacija.soba.setBrojSobe(rs.getString("BrojSobe"));
                rezervacija.klijent.setIme(rs.getString("ime"));
                rezervacija.klijent.setPrezime(rs.getString("prezime"));
                rezervacija.setPoeni(rs.getInt("Poeni"));
                rezervacija.soba.Hotel.setIme(rs.getString("NazivHotela"));
                rezervacije.add(rezervacija);
             }
 
        }
        catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        
        return rezervacije; 
    }
    
    @Override
    public ArrayList<Datumi> listaRezervisanihDatuma(Rezervacija rezervacija) throws SQLException {

        ArrayList<Datumi> datumi = new ArrayList<>();
        Statement st;
        
        try {
            String upit = "select DatumDolaska, DatumOdlaska from rezervacije "
                    + "where StatusRezervacije = 1 and SobaId = " + rezervacija.getSobaID();
            
            st = con.createStatement();
            ResultSet rs = st.executeQuery(upit);

            while (rs.next()) {
                Datumi datum = new Datumi(rs.getString("DatumDolaska"), rs.getString("DatumOdlaska"));
                datumi.add(datum);
            }

            return datumi;
        } 
        catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    @Override
    public ArrayList<Rezervacija> aktivneRezervacije(String Id) throws SQLException {

        ArrayList<Rezervacija> rezervacije = new ArrayList<>();
        Statement st;
        
        try {
            String upit = "select Id, datumOdlaska, datumDolaska, VremeOdlaska, StatusRezervacije"
                    + " from  rezervacije "
                    + "where StatusRezervacije = 1 and "
                    + "(datumDolaska >= date(now()) or "
                    + " (datumOdlaska > date(now()) and datumDolaska <= date(now()))) "
                    + "and sobaId = " + Id;

            st = con.createStatement();
            ResultSet rs = st.executeQuery(upit);

            while (rs.next()) {
                Rezervacija rezervacija = new Rezervacija();
                rezervacija.setId(rs.getInt("Id"));
                rezervacija.setDatumOdlaska(rs.getString("datumOdlaska"));
                rezervacija.setDatumDolaska(rs.getString("datumDolaska"));
                rezervacija.setVremeOdlaska(rs.getString("VremeOdlaska"));
                rezervacija.setStatusRezervacije(rs.getBoolean("StatusRezervacije"));
                rezervacije.add(rezervacija);
            }

        } 
        catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
        } 
        finally {
            con.close();
        }

        return rezervacije;
    }
    
    @Override
    public ArrayList<Rezervacija> rezervacijeMenadzerovihHotela(Integer MenadzerId) throws SQLException{
        
        ArrayList<Rezervacija> rezervacije = new ArrayList<Rezervacija>();
        try {
           
             String select = "select r.id, r.DatumDolaska, r.DatumOdlaska,"
                           + "r.Novac, r.BrojOdraslih, r.BrojDece, s.BrojSobe, r.SobaId, r.KlijentId,"
                           + "(select ime from korisnici where id = r.KlijentID) as Ime,"
                           + "(select Prezime from korisnici where id = r.KlijentID) as Prezime,"
                           + "r.VremeOdlaska, r.StatusRezervacije, r.Poeni, h.Naziv as 'NazivHotela'"     
                           + "from rezervacije r "
                           + "join sobe s on s.Id = r.SobaID "
                           + "join hotel h on h.id = s.HotelID "
                           + "join menadzerihotela mh on mh.HotelID = h.Id "
                           + "join korisnici k on k.id = mh.KlijentID "
                           + "where mh.KlijentId = " + MenadzerId;
                           
                            
        
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(select);
             
             while(rs.next()){
                 Rezervacija rezervacija = new Rezervacija();
                 rezervacija.setId(rs.getInt("Id"));
                 rezervacija.setDatumDolaska(rs.getString("DatumDolaska"));
                 rezervacija.setDatumOdlaska(rs.getString("DatumOdlaska"));
                 rezervacija.setNovac(rs.getDouble("Novac"));
                 rezervacija.setBrojOdraslih(rs.getInt("BrojOdraslih"));
                 rezervacija.setBrojDece(rs.getInt("BrojDece"));
                 rezervacija.setSobaID(rs.getInt("SobaID"));
                 rezervacija.setKorisnikId(rs.getInt("KlijentID"));
                 rezervacija.setVremeOdlaska(rs.getString("VremeOdlaska"));
                 rezervacija.setStatusRezervacije(rs.getBoolean("StatusRezervacije"));
                 rezervacija.soba.setBrojSobe(rs.getString("BrojSobe"));
                 rezervacija.klijent.setIme(rs.getString("Ime"));
                 rezervacija.klijent.setPrezime(rs.getString("Prezime"));
                 rezervacija.setPoeni(rs.getInt("Poeni"));
                 rezervacija.soba.Hotel.setIme(rs.getString("NazivHotela"));
                 rezervacije.add(rezervacija);
             }
 
        } catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        return rezervacije; 
    }
    
    @Override
    public Integer insert(Rezervacija rezervacija) throws SQLException{
        
        Integer poslednjiId = 0;
        String insert = "INSERT INTO `Rezervacije`( `DatumDolaska`, `DatumOdlaska`, `Novac`, "
                + "`BrojOdraslih`, `BrojDece`, `SobaID`, `KlijentID`, `VremeOdlaska`, `StatusRezervacije`, Poeni)"
                + " VALUES (?,?,?,?,?,?,?,?,?,?)";
        
        try {
           
            PreparedStatement pst = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
            
            pst.setString(1,rezervacija.getDatumDolaska());
            pst.setString(2,rezervacija.getDatumOdlaska());
            pst.setDouble(3, rezervacija.getNovac());
            pst.setInt(4, rezervacija.getBrojOdraslih());
            pst.setInt(5, rezervacija.getBrojDece());
            pst.setInt(6, rezervacija.getSobaID());
            pst.setInt(7, rezervacija.getKorisnikId());
            pst.setString(8, rezervacija.getVremeOdlaska());
            pst.setBoolean(9, rezervacija.getStatusRezervacije());
            pst.setInt(10, rezervacija.getPoeni());
            pst.executeUpdate();
            
            ResultSet rs = pst.getGeneratedKeys();

            while(rs.next())
                poslednjiId  = rs.getInt(1);
            
            return poslednjiId;
        } catch (SQLException ex) {
            return 0;
        }  
    }
    
    @Override
    public boolean updateStatusRezervacije(String Id, String novac) throws SQLException{
        
        String update = "";
        
        if(novac!=null)
           update = "update rezervacije  set StatusRezervacije = 1, Poeni = 0 where Id = ?";
        else
           update = "update rezervacije  set StatusRezervacije = 1, novac = 0 where Id = ?"; 

        try {
            PreparedStatement pst = con.prepareStatement(update);
            pst.setString(1, Id);
            pst.executeUpdate();
            return true;
        }
        catch (SQLException e) {
            return false;
        }
    }
    
    @Override
    public boolean delete(String Id, Double Novac, Double Poeni) throws SQLException{
        
        String update = "";
            if(Novac > 0){
                update = "update korisnici"
                        + " set Poeni = Poeni - "
                        + "(select poeni from sobe where  id = (select sobaId from rezervacije where id = "+Id+"))"
                        + " where id = (select klijentId from rezervacije where id = "+Id+")";
            }
            else if (Novac == 0){
                 update = "update korisnici"
                          +" set Poeni = Poeni - "
                          + "(select poeni from sobe where  id = (select sobaId from rezervacije where id = "+Id+")) + " +Poeni
                          + " where id = (select klijentId from rezervacije where id = "+Id+")";
            }
                 
            
            String delete = "delete from  rezervacije where id = " + Id;
        
        try {
            
            PreparedStatement psUpdate  = con.prepareStatement(update);
            
            PreparedStatement psDelete  = con.prepareStatement(delete);
            
            psUpdate.executeUpdate();
            psDelete.executeUpdate();
  
        } catch (SQLException ex) {
           Logger.getLogger(BrisanjeRezervacije.class.getName()).log(Level.SEVERE, null, ex);
        }
        
      return true;
    }
    
    @Override
    public boolean aktivnaRezervacija(Integer Id) throws SQLException{
        
        Statement st;
        String select = "select Id from rezervacije where datumOdlaska > date(now()) "
                + "and datumDolaska <= date(now()) and id = " + Id;
        
        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            if(rs.next())
                return true;

        } catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        finally{
            con.close();
        }
        
        return false;
    }
    
    @Override
    public boolean isteklaRezervacija(Integer Id) throws SQLException{
        
        Statement st;
        String select = "select Id from rezervacije where datumOdlaska < date(now()) and id = " + Id;
        
        try {
            
            st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            if(rs.next())
                return true;

        } catch (SQLException ex) {
            Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        finally{
            con.close();
        }
        
        return false;
    }
    
    public boolean unosDatuma(Rezervacija rezervacija){
        
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
        
        // proverava se da li je korisnik uneo negativan datum
        if (rezervacija.getDatumDolaska().compareTo(timeStamp) < 0)
            return false;
        
        int godinaDolaska =Integer.parseInt(rezervacija.getDatumDolaska().substring(0, 4));
        int mesecDolaska =Integer.parseInt( rezervacija.getDatumDolaska().substring(5, 7));
        int danDolaska = Integer.parseInt(rezervacija.getDatumDolaska().substring(8, 10));
        
        int godinaOdlaska = Integer.parseInt( rezervacija.getDatumOdlaska().substring(0, 4));
        int mesecOdlaska = Integer.parseInt(rezervacija.getDatumOdlaska().substring(5, 7));
        int danOdlaska = Integer.parseInt( rezervacija.getDatumOdlaska().substring(8, 10));
        
        if (godinaDolaska > godinaOdlaska)
            return  false;
        
        if(godinaDolaska == godinaOdlaska)
            if(mesecDolaska > mesecOdlaska)
                return  false;
        
        if(mesecDolaska == mesecOdlaska)
            if(danDolaska > danOdlaska)
                return false;
        
        return true;
    }
    
    public boolean proveraDostupnihTermina(Rezervacija rezervacija, ArrayList<Datumi> rezervisaniDatumi){
        
        if(rezervisaniDatumi.size()== 0)
            return true;
        
        if(rezervisaniDatumi.size()==1){
            if((rezervacija.getDatumDolaska().compareTo(rezervisaniDatumi.get(0).getDatumDolaska()) < 0
               && rezervacija.getDatumOdlaska().compareTo(rezervisaniDatumi.get(0).getDatumDolaska()) < 0 )
               || (rezervacija.getDatumDolaska().compareTo(rezervisaniDatumi.get(0).getDatumOdlaska()) > 0 ))
                return true;
            else
                return false;
        }
        
        
        for(int i = 0; i < rezervisaniDatumi.size(); i++){
            if(i == rezervisaniDatumi.size()-1)
                if(rezervacija.getDatumDolaska().compareTo(rezervisaniDatumi.get(i).getDatumOdlaska()) > 0)
                    return true;
                else
                    return false;

            if( rezervacija.getDatumDolaska().compareTo(rezervisaniDatumi.get(i).getDatumOdlaska()) > 0
                && rezervacija.getDatumOdlaska().compareTo(rezervisaniDatumi.get(i+1).getDatumDolaska()) < 0 )  
                   
            return true;
        }
        return false;
    }
    
    @Override
    public boolean dostupna(Rezervacija rezervacija) throws SQLException{
        
        ArrayList<Datumi> listaDatuma =  listaRezervisanihDatuma(rezervacija);
        Statement st;
        String upit = "select id "
                    + "from rezervacije "
                    + " where DatumDolaska = "+rezervacija.getDatumDolaska()
                    + " and DatumOdlaska = "+rezervacija.getDatumOdlaska();
        
        try {
            
            if(listaDatuma.size()!=0){
                if(unosDatuma(rezervacija) && (proveraDostupnihTermina(rezervacija, listaDatuma))){


                  st = con.createStatement();
                  ResultSet rs = st.executeQuery(upit);

                  while(rs.next()){
                      return false;
                  }

                  return  true;
               }
               else
                   return  false;
            }
            else if(unosDatuma(rezervacija)){
                  return true;
            }
            } 
            catch (SQLException ex) {

                Logger.getLogger(RezervacijaRepo.class.getName()).log(Level.SEVERE, null, ex);
            }
            finally{
               con.close();
            }
            return false;
    }
    
    public long duzinaRezervacije(Rezervacija rezervacija){

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try{
            Date date1 = dateFormat.parse(rezervacija.getDatumDolaska());
            Date date2 = dateFormat.parse(rezervacija.getDatumOdlaska());
            long brojDana =  Math.abs(date2.getTime() - date1.getTime());
            
            return TimeUnit.DAYS.convert(brojDana, TimeUnit.MILLISECONDS);

        }catch(ParseException e){
            e.printStackTrace();
            return 0;
        }
    }
}
