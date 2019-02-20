package RepoPattern;

import Models.Korisnik;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import DAO.KorisnikDAO;

/**
 *
 * @author Pavle
 */
public class KorisnikRepo implements KorisnikDAO {

    Connection con;
    String url = "jdbc:mysql://localhost:3306/sobehotela";
    String user = "root";
    String pass = "";

    public KorisnikRepo() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public ArrayList<Korisnik> lista() throws SQLException {
        ArrayList<Korisnik> korisnici = new ArrayList<Korisnik>();

        String select = "select * from korisnici";

        try {

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while (rs.next()) {
                Korisnik kor = new Korisnik();
                kor.setId(rs.getInt("Id"));
                kor.setIme(rs.getString("Ime"));
                kor.setPrezime(rs.getString("Prezime"));
                kor.setKorisnickoIme(rs.getString("KIme"));
                kor.setEmail(rs.getString("Email"));
                kor.setTelefon(rs.getString("Telefon"));
                kor.setAdresa(rs.getString("Adresa"));
                kor.setGrad(rs.getString("Grad"));
                kor.setDrzava(rs.getString("Drzava"));
                kor.setRola(Integer.toString(rs.getInt("RolaID")));
                kor.setPoeni(rs.getInt("Poeni"));
                kor.setPostanskiBroj(rs.getString("PostanskiBroj"));
                korisnici.add(kor);
            }

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        return korisnici;
    }

    @Override
    public Korisnik select(String Id) throws SQLException {

        Korisnik kor = new Korisnik();
        try {
            String select = "select *from korisnici where id = " + Id;
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while (rs.next()) {
                kor.setId(rs.getInt("Id"));
                kor.setIme(rs.getString("Ime"));
                kor.setPrezime(rs.getString("Prezime"));
                kor.setKorisnickoIme(rs.getString("KIme"));
                kor.setEmail(rs.getString("Email"));
                kor.setTelefon(rs.getString("Telefon"));
                kor.setAdresa(rs.getString("Adresa"));
                kor.setGrad(rs.getString("Grad"));
                kor.setDrzava(rs.getString("Drzava"));
                kor.setRola(Integer.toString(rs.getInt("RolaID")));
                kor.setPoeni(rs.getInt("Poeni"));
                kor.setPostanskiBroj(rs.getString("PostanskiBroj"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        return kor;
    }

    @Override
    public Korisnik selectByUsername(String Username) throws SQLException {

        Korisnik kor = new Korisnik();
        try {
            String select = "select * from korisnici where Kime = '" + Username + "'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while (rs.next()) {
                kor.setId(rs.getInt("Id"));
                kor.setIme(rs.getString("Ime"));
                kor.setPrezime(rs.getString("Prezime"));
                kor.setKorisnickoIme(rs.getString("KIme"));
                kor.setEmail(rs.getString("Email"));
                kor.setTelefon(rs.getString("Telefon"));
                kor.setAdresa(rs.getString("Adresa"));
                kor.setGrad(rs.getString("Grad"));
                kor.setDrzava(rs.getString("Drzava"));
                kor.setRola(Integer.toString(rs.getInt("RolaID")));
                kor.setPoeni(rs.getInt("Poeni"));
                kor.setPostanskiBroj(rs.getString("PostanskiBroj"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        return kor;
    }

    @Override
    public boolean insert(Korisnik kor) throws SQLException {
        try {
            String insertToKlijent = "INSERT INTO `korisnici`(Ime, Prezime, KIme, Sifra, Email, Telefon,"
                    + " Adresa, Grad, Drzava, Poeni, PostanskiBroj, RolaID)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = con.prepareStatement(insertToKlijent);

            pst.setString(1, kor.getIme());
            pst.setString(2, kor.getPrezime());
            pst.setString(3, kor.getKorisnickoIme());
            pst.setString(4, kor.getSifra());
            pst.setString(5, kor.getEmail());
            pst.setString(6, kor.getTelefon());
            pst.setString(7, kor.getAdresa());
            pst.setString(8, kor.getGrad());
            pst.setString(9, kor.getDrzava());
            pst.setDouble(10, 0.0);
            pst.setString(11, kor.getPostanskiBroj());
            pst.setInt(12, 1);

            pst.executeUpdate();

            return true;
        } catch (SQLException e) {
        }

        return false;
    }

    @Override
    public boolean update(Korisnik kor, String ulogovanaRola) throws SQLException {

        String poeni = "";
        String rolaID = "";
        if (ulogovanaRola.equals("2")) {
            poeni = "Poeni = ?,";
            rolaID = "RolaID = ?,";
        }

        String deleteFromMenadzeri = "delete from  menadzerihotela where klijentId = " + kor.getId();
        String update = "update korisnici "
                + "set Ime = ?,"
                + "Prezime = ?,"
                + "KIme = ?,"
                + "Email = ?,"
                + "Telefon = ?,"
                + "Adresa = ?,"
                + "Drzava = ?,"
                + "Grad = ?,"
                + rolaID
                + poeni
                + "PostanskiBroj = ?"
                + " where id = ?";

        try {
            //brisanje iz many to many tabele ako je prethodno bio menadzer
            PreparedStatement pstDelete = con.prepareStatement(deleteFromMenadzeri);
            pstDelete.executeUpdate();

            PreparedStatement pst = con.prepareStatement(update);
            pst.setString(1, kor.getIme());
            pst.setString(2, kor.getPrezime());
            pst.setString(3, kor.getKorisnickoIme());
            pst.setString(4, kor.getEmail());
            pst.setString(5, kor.getTelefon());
            pst.setString(6, kor.getAdresa());
            pst.setString(7, kor.getDrzava());
            pst.setString(8, kor.getGrad());

            if (ulogovanaRola.equals("2")) {
                pst.setInt(9, Integer.parseInt(kor.getRola()));
                pst.setDouble(10, kor.getPoeni());
                pst.setString(11, kor.getPostanskiBroj());
                pst.setInt(12, kor.getId());
            } else {
                pst.setString(9, kor.getPostanskiBroj());
                pst.setInt(10, kor.getId());
            }

            pst.executeUpdate();

            return true;

        } catch (SQLException e) {
            return false;
        }
    }

    @Override
    public boolean updatePoeniNakonPlacanjaNovcem(String Username, Integer BrojPoena) throws SQLException {

        String update = "update korisnici set Poeni = Poeni + " + BrojPoena + " where KIme = '" + Username + "'";

        try {
            PreparedStatement pst = con.prepareStatement(update);
            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            return false;
        }
    }

    @Override
    public boolean updatePoeniNakonPlacanjaPoenima(String Username, Integer BrojPoena, Integer BrojPoenaSobe) throws SQLException {
        String update = "update korisnici "
                + "set Poeni = Poeni - " + BrojPoena + " + " + BrojPoenaSobe
                + " where KIme = '" + Username + "'";
        try {
            PreparedStatement pst = con.prepareStatement(update);
            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            return false;
        } finally {
            con.close();
        }
    }

    @Override
    public boolean promenaLozinke(String username, String staraLozinka, String novaLozinka) throws SQLException {

        String select = "select Sifra from korisnici where KIme = '" + username + "' and Sifra = '" + staraLozinka + "'";
        String update = "update korisnici set sifra = '" + novaLozinka + "' where KIme = '" + username + "'";
        Statement st;

        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            if (rs.next()) {
                st.executeUpdate(update);
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            con.close();
        }
    }

    @Override
    public boolean delete(String Id) throws SQLException {

        try {

            String select = "select rolaID from korisnici where id = " + Id;
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            //ako je rola admin onda se ne moze izbrisati iz baze
            if (rs.next()) {
                if (rs.getInt("RolaID") == 2) {
                    return false;
                }
            }

            String delete = "delete from  korisnici where id = " + Id;
            PreparedStatement ps = con.prepareStatement(delete);

            ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        return true;
    }

    @Override
    public boolean logovanje(String username, String password) throws SQLException {

        String provera = "select * from korisnici where KIme = '" + username + "'  and Sifra = '" + password + "'";

        PreparedStatement pst;
        try {

            pst = con.prepareStatement(provera);
            ResultSet rs = pst.executeQuery(provera);

            while (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        return false;
    }

    @Override
    public String Rola(String username, String password) throws SQLException {
        String select = "select RolaID from korisnici where sifra = '" + password + "' and KIme = '" + username + "'";
        Statement st;
        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while (rs.next()) {
                return rs.getString("RolaID");
            }

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }

        return "Greska";
    }

    @Override
    public Integer brojPoena(String username) throws SQLException {

        String select = "select Poeni from korisnici where KIme = '" + username + "'";
        Statement st;

        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(select);

            while (rs.next()) {
                return rs.getInt("Poeni");
            }

        } catch (SQLException ex) {
            Logger.getLogger(KorisnikRepo.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            con.close();
        }
        return 0;
    }
}
