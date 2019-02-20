package DAO;

import Models.Soba;
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
public interface SobeDAO {
    
    ArrayList<Soba> listaSobaIzabranogHotela(String Hotel_Id) throws SQLException;
    Soba select(String Id) throws SQLException;
    boolean insert(Soba soba, Part part) throws SQLException, IOException;
    String update(Soba soba, Part part) throws SQLException, IOException;
    String delete(String Id) throws SQLException;
    int maxKapacitetSobe(String Id) throws SQLException;
    void fotografije(HttpServletRequest request, HttpServletResponse response, String SobaId)throws ServletException, IOException, SQLException;

}
