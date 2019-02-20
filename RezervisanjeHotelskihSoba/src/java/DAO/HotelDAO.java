package DAO;

import Models.Hotel;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Pavle
 */
public interface HotelDAO {
    
    ArrayList<Hotel> lista() throws SQLException;
    Hotel select(String Id) throws SQLException;
    boolean insert(Hotel hotel, Part part) throws SQLException;
    boolean update(Hotel hotel, Part part) throws SQLException, IOException;
    void delete (String Id) throws SQLException;
    void fotografije(HttpServletRequest request, HttpServletResponse response, String HotelID)
            throws ServletException, IOException, SQLException ;
}   
