package RepoPattern;

import DAO.SobeDAO;
import Models.Soba;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Pavle
 */
public class SobeRepo implements SobeDAO {

    Connection con;
    String url = "jdbc:mysql://localhost:3306/sobehotela";
    String user = "root";
    String pass = "";
    
    public SobeRepo() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public ArrayList<Soba> listaSobaIzabranogHotela(String Hotel_Id) throws SQLException{
        
        ArrayList<Soba> sobe = new ArrayList<Soba>();
        try {
           
            String select = "select s.Id,s.TipSobeID, s.HotelID, s.BrojSobe, s.Fotografija,"
                            + " h.Naziv as 'NazivHotela', ts.Naziv as 'NazivTipaSobe', s.KratkiOpis as 'KratkiOpis',"
                            + "s.Opis as 'Opis',s.Cena as 'Cena', s.Kapacitet as 'Kapacitet', s.Poeni as 'Poeni',"
                            + "s.CenaUPoenima as 'CenaUPoenima'"
                            + "from Sobe s "
                            + "join TipSobe ts on s.TipSobeID = ts.id "
                            + "join Hotel h on h.Id = s.HotelID "
                            + "where h.Id = " + Hotel_Id;

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while(rs.next()){
                Soba soba = new Soba();
                soba.setId(rs.getInt("Id"));
                soba.setBrojSobe(rs.getString("BrojSobe"));
                soba.setTipSobeID(Integer.parseInt(rs.getString("TipSobeID")));
                soba.setHotelID(Integer.parseInt(rs.getString("HotelID")));
                soba.setSlika(rs.getBlob("Fotografija"));     
                soba.Hotel.setIme(rs.getString("NazivHotela"));                 
                soba.TipSobe.setNaziv(rs.getString("NazivTipaSobe"));
                soba.setKratkiOpis(rs.getString("KratkiOpis"));
                soba.setOpis(rs.getString("Opis"));
                soba.setCena(rs.getDouble("Cena"));
                soba.setKapacitet(rs.getInt("Kapacitet"));
                soba.setPoeni(rs.getInt("Poeni"));
                soba.setCenaUPoenima(rs.getInt("CenaUPoenima"));
                sobe.add(soba);
            }
             
        } 
        catch (SQLException ex) {
            Logger.getLogger(SobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        
        return sobe; 
    }
    
    @Override
    public Soba select(String Id) throws SQLException{
        
        Soba soba = new Soba();
        String select = "select s.Id,s.TipSobeID, s.HotelID, s.BrojSobe, s.Fotografija,"
                            + " h.Naziv as 'NazivHotela', ts.Naziv as 'NazivTipaSobe', s.KratkiOpis as 'KratkiOpis',"
                            + "s.Opis as 'Opis',s.Cena as 'Cena', s.Kapacitet as 'Kapacitet', s.Poeni as 'Poeni',"
                            + "s.CenaUPoenima as 'CenaUPoenima' "
                            + "from Sobe s "
                            + "join TipSobe ts on s.TipSobeID = ts.id "
                            + "join Hotel h on h.Id = s.HotelID "
                            + "where s.Id = " + Id;
        try {
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while(rs.next()){
                soba.setId(rs.getInt("Id"));
                soba.setBrojSobe(rs.getString("BrojSobe"));
                soba.setTipSobeID(Integer.parseInt(rs.getString("TipSobeID")));
                soba.setHotelID(Integer.parseInt(rs.getString("HotelID")));
                soba.setSlika(rs.getBlob("Fotografija"));                 
                soba.Hotel.setIme(rs.getString("NazivHotela"));
                soba.TipSobe.setNaziv(rs.getString("NazivTipaSobe"));
                soba.setKratkiOpis(rs.getString("KratkiOpis"));
                soba.setOpis(rs.getString("Opis"));
                soba.setCena(rs.getDouble("Cena"));
                soba.setKapacitet(rs.getInt("Kapacitet"));
                soba.setPoeni(rs.getInt("Poeni"));
                soba.setCenaUPoenima(rs.getInt("CenaUPoenima"));
            }
        } 
        catch (SQLException ex) {
           Logger.getLogger(SobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        return  soba;
    }
    
    @Override
    public boolean insert(Soba soba, Part part) throws SQLException, IOException{
        
        String insert = "INSERT INTO `sobe`(`BrojSobe`, `TipSobeID`, `HotelID`, `Fotografija`,"
                      + " Opis, KratkiOpis,  Cena,  Kapacitet, Poeni, CenaUPoenima) "
                      + "VALUES (?,?,?,?,?,?,?,?,?,?)";
        try {
           
            PreparedStatement pst = con.prepareStatement(insert);
            
            pst.setString(1, soba.getBrojSobe());
            pst.setInt(2, soba.getTipSobeID());
            pst.setInt(3, soba.getHotelID());
            
            InputStream is = part.getInputStream();
            pst.setBlob(4, is);
            pst.setString(5, soba.getOpis());
            pst.setString(6, soba.getKratkiOpis());
            pst.setDouble(7, soba.getCena());
            pst.setDouble(8, soba.getKapacitet());
            pst.setInt(9, soba.getPoeni());
            pst.setInt(10, soba.getCenaUPoenima());
            pst.executeUpdate();
           
            return true;
        } 
        catch (SQLException ex) {
            return false;
        } 
        catch (IOException ex) {
            Logger.getLogger(SobeRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    @Override
    public String update(Soba soba, Part part) throws SQLException, IOException{
        
        String getHotelID ="select HotelID from sobe where ID = " + soba.getId();
        
        String fotografija = "Fotografija = ?,";
        
        String update = "update sobe "
                      + "set BrojSobe = ?,"
                      + "TipSobeID = ?,"
                      + "KratkiOpis = ?,"
                      + "Cena = ?,"
                      + "Kapacitet = ?,"
                      + "Poeni = ?,"
                      + "CenaUPoenima = ?,";
        if (part.getSize()!=0)
            update += fotografija;
    
        update += "Opis = ? "+
                  "where id = ?";      
                
         
        try {
            PreparedStatement pst = con.prepareStatement(update);

            pst.setString(1, soba.getBrojSobe());
            pst.setInt(2, soba.TipSobe.getId());
            pst.setString(3, soba.getKratkiOpis());
            pst.setDouble(4, soba.getCena());
            pst.setInt(5, soba.getKapacitet());
            pst.setInt(6, soba.getPoeni());
            pst.setInt(7,soba.getCenaUPoenima());
            InputStream is;
            
            if(part.getSize()!=0){
                is = part.getInputStream();
                pst.setBlob(8, is);
                pst.setString(9,soba.getOpis());
                pst.setInt(10, soba.getId());
            }
            else{
                pst.setString(8, soba.getOpis());
                pst.setInt(9, soba.getId());
            }
            Statement st = con.createStatement();
            ResultSet rs =st.executeQuery(getHotelID);
            
            String HotelID = "";
            while(rs.next())
                HotelID = rs.getString("HotelID");
            
            pst.executeUpdate();
            
            return HotelID;
            
        } catch (SQLException e) {
          return "";
        }
        finally{
            con.close();
        }
        
    }
    
    @Override
    public String delete(String Id) throws SQLException{
        
        String HotelID = "";
        String selectHotelID = "select HotelID from sobe where id = "+ Id;
        String delete = "delete from  sobe where id = " + Id;
        
        try {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(selectHotelID);
            while(rs.next())
                HotelID = rs.getString("HotelID");
            
            PreparedStatement ps  = con.prepareStatement(delete);
            ps.executeUpdate();
  
        } 
        catch (SQLException ex) {
            Logger.getLogger(SobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        return HotelID;
    }
    
    @Override
    public int maxKapacitetSobe(String Id) throws SQLException{
        
        Statement st;
        String select = "select max(Kapacitet) as 'Kapacitet' from sobe where Id = " +Id;
        int maxKapacitet = 0;
        try {

            st = con.createStatement();

            ResultSet rs = st.executeQuery(select);
            while (rs.next()) 
                maxKapacitet = rs.getInt("Kapacitet");                
        } catch (SQLException ex) {

        }
        finally{
            con.close();
        }
        
        return maxKapacitet;
    }
    
    @Override
    public void fotografije(HttpServletRequest request, HttpServletResponse response, String SobaId)throws ServletException, IOException, SQLException {
        
        Statement st;
        String select = "select fotografija from sobe where id = " + SobaId;
        try {

            st = con.createStatement();
            byte[] imgData = null;
            ResultSet rs = st.executeQuery(select);
            while (rs.next()) 
            {
                Blob image = rs.getBlob(1);
                imgData = image.getBytes(1,(int)image.length());
            }
            response.setContentType("image/jpg");
            try (OutputStream o = response.getOutputStream()) {
                o.write(imgData);
                o.flush();
            }
        } 
        catch (SQLException ex) {

        }
        finally{
            con.close();
        }   
    }
}
