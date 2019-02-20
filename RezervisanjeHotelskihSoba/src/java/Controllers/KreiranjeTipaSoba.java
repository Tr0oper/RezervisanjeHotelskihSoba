package Controllers;

import Models.TipSobe;
import RepoPattern.TipSobeRepo;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Pavle
 */
public class KreiranjeTipaSoba extends HttpServlet {

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
            TipSobe tipSobe = new  TipSobe();
            tipSobe.setNaziv(request.getParameter("Naziv"));
            tipSobe.setHotelID(Integer.parseInt(request.getParameter("Hotel_Id")));
            
            

            if(new TipSobeRepo().insert(tipSobe)){
               response.sendRedirect("PromenaHotela.jsp?Hotel_Id=" + request.getParameter("Hotel_Id"));
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
