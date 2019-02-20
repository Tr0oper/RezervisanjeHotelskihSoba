
package Controllers;

import RepoPattern.KorisnikRepo;
import RepoPattern.MenadzerHotelaRepo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pavle
 */
public class Login extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession  sesija = request.getSession();
            String  username = request.getParameter("username");
            String password = request.getParameter("password");
            String ulogovanaRola = new KorisnikRepo().Rola(username, password);
            
            if(new KorisnikRepo().logovanje(username, password)){
                if(ulogovanaRola.equals("3"))
                    sesija.setAttribute("HotelId", new MenadzerHotelaRepo().select(new KorisnikRepo().selectByUsername(username).getId()).getHotelId());
                sesija.setAttribute("ulogovan", username); 
                sesija.setAttribute("UlogovanaRola", ulogovanaRola);
                sesija.setAttribute("BrojPoenaKorisnika", new KorisnikRepo().brojPoena(username));
                request.setAttribute("prvoLogovanje", "True");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            else{
                request.setAttribute("prvoLogovanje", "False");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }    
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
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
