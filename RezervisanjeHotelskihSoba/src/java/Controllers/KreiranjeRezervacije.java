package Controllers;

import Models.Korisnik;
import Models.Rezervacija;
import Models.Soba;
import RepoPattern.KorisnikRepo;
import RepoPattern.RezervacijaRepo;
import RepoPattern.SobeRepo;
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
public class KreiranjeRezervacije extends HttpServlet {


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
        Rezervacija rezervacija = new Rezervacija();
        
        try {
            Soba soba = new SobeRepo().select(request.getParameter("Soba_Id"));
            Korisnik kor = new KorisnikRepo().selectByUsername((String) request.getSession().getAttribute("ulogovan"));
            
            rezervacija.setDatumDolaska(request.getParameter("DatumDolaska"));
            rezervacija.setDatumOdlaska(request.getParameter("DatumOdlaska"));
            rezervacija.setBrojOdraslih(Integer.parseInt(request.getParameter("BrojOdraslih")));
            rezervacija.setBrojDece(Integer.parseInt(request.getParameter("BrojDece")));
            rezervacija.setSobaID(Integer.parseInt(request.getParameter("Soba_Id")));
            rezervacija.setVremeOdlaska(request.getParameter("VremeOdlaska"));
            rezervacija.setStatusRezervacije(false);
            rezervacija.setKorisnikId(kor.getId());
            
            long brojDana = new RezervacijaRepo().duzinaRezervacije(rezervacija);
            double racun = brojDana * Double.parseDouble(request.getParameter("CenaSobe"));
            rezervacija.setNovac(racun);

            //Integer Poeni = Math.round(brojDana * soba.getCena());
            rezervacija.setPoeni(soba.getCenaUPoenima());
            
            try {
                
                if(new RezervacijaRepo().dostupna(rezervacija)){
                    String Rezervacija_Id =  new RezervacijaRepo().insert(rezervacija).toString();
                    Cookie cookie = new Cookie("Rezervacija_Id", Rezervacija_Id);
                    cookie.setMaxAge(1000);
                    response.addCookie(cookie);
                    request.setAttribute("Racun", racun);
                    request.setAttribute("CenaUPoenima", soba.getCenaUPoenima());
                    request.setAttribute("BrojPoena", soba.getPoeni());
                    request.getRequestDispatcher("Placanje.jsp").forward(request, response);
                }
                else{
                    request.setAttribute("Greska", "False");
                    request.getRequestDispatcher("Rezervisanje.jsp?Soba_Id="+soba.getId()).forward(request, response);
                }
            } 
            catch (SQLException ex) {
                Logger.getLogger(KreiranjeRezervacije.class.getName()).log(Level.SEVERE, null, ex);
            }
        } 
        catch (SQLException ex) {
            Logger.getLogger(KreiranjeRezervacije.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
