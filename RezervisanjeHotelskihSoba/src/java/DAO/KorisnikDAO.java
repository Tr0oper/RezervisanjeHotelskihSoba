package DAO;

import Models.Korisnik;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Pavle
 */
public interface KorisnikDAO {
    
    ArrayList<Korisnik> lista() throws SQLException;
    Korisnik select(String Id) throws SQLException;
    Korisnik selectByUsername(String Username) throws SQLException;
    boolean insert(Korisnik klijent) throws SQLException;
    boolean update(Korisnik klijent, String ulogovanaRola) throws SQLException;
    boolean updatePoeniNakonPlacanjaNovcem(String Username, Integer BrojPoena) throws SQLException;
    boolean updatePoeniNakonPlacanjaPoenima(String Username, Integer BrojPoena, Integer BrojPoenaSobe) throws SQLException;
    boolean promenaLozinke(String username, String staraLozinka, String novaLozinka) throws SQLException;
    boolean delete(String Id) throws SQLException;
    boolean logovanje(String username, String password) throws SQLException;
    String Rola(String username, String password) throws SQLException;
    Integer brojPoena(String username) throws SQLException;
}
