package DAO;

import Models.TipSobe;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Pavle
 */
public interface TipSobeDAO {
    
    ArrayList<TipSobe> lista(String HotelID) throws SQLException;
    boolean insert(TipSobe tipSobe) throws SQLException, IOException;
    boolean delete(String Niz_ID) throws SQLException;
    
}
