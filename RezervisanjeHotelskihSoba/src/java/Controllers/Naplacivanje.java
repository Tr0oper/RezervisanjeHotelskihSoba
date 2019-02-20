package Controllers;

import Models.KreditnaKartica;
import RepoPattern.KorisnikRepo;
import RepoPattern.RezervacijaRepo;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Pavle
 */
public class Naplacivanje extends HttpServlet {

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

        KreditnaKartica kreditnaKartica = new KreditnaKartica();
        kreditnaKartica.setVrsta(request.getParameter("VrstaKartice"));
        kreditnaKartica.setBrojRacuna(request.getParameter("BrojKartice"));
        kreditnaKartica.setMesecIsteka(Integer.parseInt(request.getParameter("DatumIstekaMesec")));
        kreditnaKartica.setGodinaIsteka(Integer.parseInt(request.getParameter("DatumIstekaGodina")));

        try {
            Cookie[] cookies = request.getCookies();
            String Rezervacija_Id = "";
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("Rezervacija_Id")) {
                    Rezervacija_Id = cookie.getValue();
                }
            }

            if (new RezervacijaRepo().updateStatusRezervacije(Rezervacija_Id, request.getParameter("NaplacivanjeNovcem"))) {

                if (request.getParameter("NaplacivanjeNovcem") != null) {
                    new KorisnikRepo().updatePoeniNakonPlacanjaNovcem((String) request.getSession().getAttribute("ulogovan"), Integer.parseInt(request.getParameter("BrojPoena")));
                } else {
                    new KorisnikRepo().updatePoeniNakonPlacanjaPoenima((String) request.getSession().getAttribute("ulogovan"), Integer.parseInt(request.getParameter("CenaUPoenima")), Integer.parseInt(request.getParameter("BrojPoena")));
                }

                request.getSession().setAttribute("BrojPoenaKorisnika", new KorisnikRepo().brojPoena((String) request.getSession().getAttribute("ulogovan")));
                request.setAttribute("poruka", "True");
                request.getRequestDispatcher("Placanje.jsp").forward(request, response);
            } else {
                request.setAttribute("poruka", "False");
                request.getRequestDispatcher("Placanje.jsp").forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(Naplacivanje.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
