
package Controllers;

import Models.Korisnik;
import Models.MenadzeriHotela;
import RepoPattern.KorisnikRepo;
import RepoPattern.MenadzerHotelaRepo;
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
public class PromenaKorisnika extends HttpServlet {


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
        try {
            processRequest(request, response);
            Korisnik kor = new Korisnik();
            kor.setId(Integer.parseInt(request.getParameter("Korisnik_Id")));
            kor.setIme(request.getParameter("Ime"));
            kor.setPrezime(request.getParameter("Prezime"));
            kor.setKorisnickoIme(request.getParameter("KIme"));
            kor.setEmail(request.getParameter("Email"));
            kor.setTelefon(request.getParameter("Telefon"));
            kor.setAdresa(request.getParameter("Adresa"));
            kor.setDrzava(request.getParameter("Drzava"));
            kor.setGrad(request.getParameter("Grad"));
            kor.setRola(request.getParameter("Rola"));
            
            String ulogovanaRola = (String)request.getSession().getAttribute("UlogovanaRola");
            if(ulogovanaRola.equals("2"))
                kor.setPoeni(Integer.parseInt(request.getParameter("Poeni")));
            
            
            kor.setPostanskiBroj(request.getParameter("PostanskiBroj"));

            if(new  KorisnikRepo().update(kor, ulogovanaRola)){
                if(kor.getRola()!=null)
                    if(kor.getRola().equals("3")){

                        MenadzeriHotela menadzerHotela = new MenadzeriHotela();
                        menadzerHotela.setHotelId(Integer.parseInt(request.getParameter("HotelId")));
                        menadzerHotela.setKorisnikId(kor.getId());
                        new MenadzerHotelaRepo().insert(menadzerHotela);
                    }
                response.sendRedirect("PromenaKorisnika.jsp?Korisnik_Id="+kor.getId());
            }
                
            else
            {
                request.setAttribute("Korisnik_Id", kor.getId());
                request.setAttribute("rezultat", "False");
                request.getRequestDispatcher("PromenaKorisnika.jsp").forward(request, response);
            }
            request.getSession().setAttribute("BrojPoenaKorisnika", new KorisnikRepo().brojPoena((String)request.getSession().getAttribute("ulogovan")));
        } catch (SQLException ex) {
            Logger.getLogger(PromenaKorisnika.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
