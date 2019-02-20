
package Controllers;

import Models.Hotel;
import RepoPattern.HotelRepo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Pavle
 */
@MultipartConfig(maxFileSize = 161772716)
public class PromenaHotela extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        Hotel hotel = new Hotel();
        hotel.setHotelId(Integer.parseInt(request.getParameter("Hotel_Id")));
        hotel.setIme(request.getParameter("Naziv"));
        hotel.setDrzava(request.getParameter("Drzava"));
        hotel.setGrad(request.getParameter("Grad"));
        hotel.setAdresa(request.getParameter("Adresa"));
        hotel.setOpis(request.getParameter("Opis"));
        hotel.setBrojZvezdica(Integer.parseInt(request.getParameter("Zvezdice")));
        
        Part part = request.getPart("file");
        
        try {
            if(new HotelRepo().update(hotel, part)){
                response.sendRedirect("Hoteli.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PromenaHotela.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
