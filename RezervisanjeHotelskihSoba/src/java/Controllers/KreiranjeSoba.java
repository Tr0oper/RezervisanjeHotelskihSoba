package Controllers;

import Models.Soba;
import RepoPattern.SobeRepo;
import java.io.IOException;
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
public class KreiranjeSoba extends HttpServlet {

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
        try{
            Soba soba = new  Soba();
            soba.setBrojSobe(request.getParameter("BrojSobe"));
            soba.setTipSobeID(Integer.parseInt(request.getParameter("TipSobe")));
            soba.setHotelID(Integer.parseInt(request.getParameter("Hotel_Id")));
            soba.setOpis(request.getParameter("Opis"));
            soba.setKratkiOpis(request.getParameter("KratkiOpis"));
            soba.setCena(Double.parseDouble(request.getParameter("Cena")));
            soba.setKapacitet(Integer.parseInt(request.getParameter("Kapacitet")));
            soba.setPoeni(Integer.parseInt(request.getParameter("Poeni")));
            soba.setCenaUPoenima(Integer.parseInt(request.getParameter("CenaUPoenima")));
            //klasa koja pomaze  za insert fotografije u bazu
            Part part = request.getPart("file");
            

            if(new SobeRepo().insert(soba, part)){
               response.sendRedirect("Sobe.jsp?Hotel_Id=" + request.getParameter("Hotel_Id"));
            }
            else{
                response.sendRedirect("Greska.jsp");
            }
        }catch(Exception  ex){
             response.sendRedirect("Greska.jsp");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
