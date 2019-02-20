package DAO;

import Models.Datumi;
import Models.Rezervacija;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Pavle
 */
public interface RezervacijaDAO {
    
    ArrayList<Rezervacija> lista() throws SQLException;
    ArrayList<Datumi> listaRezervisanihDatuma(Rezervacija rezervacija) throws SQLException;
    ArrayList<Rezervacija> aktivneRezervacije(String Id) throws SQLException;
    ArrayList<Rezervacija> rezervacijeMenadzerovihHotela(Integer MenadzerId) throws SQLException;
    Integer insert(Rezervacija rezervacija) throws SQLException;
    boolean updateStatusRezervacije(String Id, String NaplacivanjeNovcem) throws SQLException;
    boolean delete(String Id, Double Novac, Double Poeni) throws SQLException;
    boolean aktivnaRezervacija(Integer Id) throws SQLException;
    boolean isteklaRezervacija(Integer Id) throws SQLException;
    boolean dostupna(Rezervacija rezervacija) throws SQLException;
}
