
package Controllers;

import RepoPattern.TipSobeRepo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Pavle
 */
public class BrisanjeTipovaSoba extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
         String[] parameterValues =  request.getParameterValues("TipSobe");
        String niz_ID = "";
        
        for(String data : parameterValues){
            niz_ID += data+",";
        }
    
        niz_ID = niz_ID.substring(0,niz_ID.length()-1);
        
        if(new  TipSobeRepo().delete(niz_ID)){
            response.sendRedirect("PromenaHotela.jsp?Hotel_Id=" + request.getParameter("Hotel_Id"));
        }
        else{
            response.sendRedirect("Greska.jsp");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BrisanjeTipovaSoba.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BrisanjeTipovaSoba.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
