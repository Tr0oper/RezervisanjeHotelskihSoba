package Controllers;


import RepoPattern.KorisnikRepo;
import RepoPattern.RezervacijaRepo;

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

public class BrisanjeRezervacije extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
           
            Integer KorisnikId = new KorisnikRepo().selectByUsername((String)request.getSession().getAttribute("ulogovan")).getId();
            if(new RezervacijaRepo().delete(request.getParameter("Rezervacije_Id")
                    ,Double.parseDouble(request.getParameter("Novac")),Double.parseDouble(request.getParameter("Poeni")))){
                request.getSession().setAttribute("BrojPoenaKorisnika", new KorisnikRepo().brojPoena((String)request.getSession().getAttribute("ulogovan")));
                request.setAttribute("rezultat", "true");
               
                String pom = request.getParameter("Profil");
                
                if(request.getParameter("Profil").equals("True"))
                     request.getRequestDispatcher("PromenaKorisnika.jsp?Korisnik_Id=" + KorisnikId).forward(request, response);
                else
                request.getRequestDispatcher("Rezervacije.jsp").forward(request, response);
               
                
                
            }
            else{
                request.getSession().setAttribute("BrojPoenaKorisnika", new KorisnikRepo().brojPoena((String)request.getSession().getAttribute("ulogovan")));
                request.setAttribute("rezultat", "false");
                if(request.getParameter("Profil").equals("True"))
                     request.getRequestDispatcher("PromenaKorisnika.jsp?Korisnik_Id=" + KorisnikId).forward(request, response);
                else
                request.getRequestDispatcher("Rezervacije.jsp").forward(request, response);
                
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(BrisanjeRezervacije.class.getName()).log(Level.SEVERE, null, ex);
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
