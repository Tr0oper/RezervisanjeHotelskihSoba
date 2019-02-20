
<%@page import="Models.Rezervacija"%>
<%@page import="RepoPattern.RezervacijaRepo"%>
<%@page import="RepoPattern.MenadzerHotelaRepo"%>
<%@page import="Models.MenadzeriHotela"%>
<%@page import="RepoPattern.HotelRepo"%>
<%@page import="Models.Hotel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page import="Models.Korisnik"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="navbar.jsp" />  
        <br><br><br>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    </head>
    <style>
        #Tabela_info{
            color: whitesmoke;
        }
        #Tabela tbody tr{
            background: rgba(0,0,0,0.5);
            color: whitesmoke;
        }
        #Tabela tbody tr:hover{
            background: rgba(0,0,0,0.7);
        }
        .table-hover thead tr{
            color: whitesmoke;
        }
        label{
            color: white;
            font-weight: bold;
        }
        select{
            visibility: hidden;
        }
        .far{
            color: whitesmoke;
        }
        .far:hover{
            color: lightgray;
        }
    </style>
    <body>
        <%
            request.setAttribute("Korisnik", new KorisnikRepo().select(request.getParameter("Korisnik_Id")));
            MenadzeriHotela mh = new MenadzerHotelaRepo().select(Integer.parseInt(request.getParameter("Korisnik_Id")));
            String ulogovanaRola = "";

            if (request.getSession().getAttribute("UlogovanaRola") != null) {
                ulogovanaRola = (String) request.getSession().getAttribute("UlogovanaRola");
            }

            Korisnik kor = (Korisnik) request.getAttribute("Korisnik");
        %>

    <center><h4 style="color: white ; font-weight: bold; margin-top: 15px">IZMENA PODATAKA O KORISNIKU: <u><%= kor.getKorisnickoIme()%></u> </h4></center>

    <form action="PromeniLozinku" method="post" id="editPassword"></form>

    <div class="row" style=" background: rgba(0, 0, 0, 0.5); border-radius: 7px; width: 650px; margin: 2% auto;">       
        <form action="PromenaKorisnika" method="post" id="promenaKorisnika">
            <input value="<%= request.getParameter("Korisnik_Id")%>" name="Korisnik_Id" type="hidden">
            <%if (ulogovanaRola.equals("3")) {
                    {%> 
            <input type="hidden" name="HotelId" value="<%= mh.getHotelId()%>"> 
            <%}
                    }%>
            <div class="col-10" style="margin-top: 15px; margin-left: 5%">
                <div class="form-group">
                    <label>Ime </label>
                    <input type="text" class="form-control" placeholder="Ime" value="<%= kor.getIme()%>" name="Ime" >
                </div>
                <div class="form-group">
                    <label>Prezime </label>
                    <input type="text" class="form-control" placeholder="Prezime" value="<%= kor.getPrezime()%>"  name="Prezime" f>
                </div>
                <div class="form-group">
                    <label>Username </label>
                    <input type="text" class="form-control" placeholder="Username" value="<%= kor.getKorisnickoIme()%>"  name="KIme">
                </div>
                <div class="form-group">
                    <label>E-mail</label>
                    <input type="text" class="form-control" placeholder="E-mail:" value="<%= kor.getEmail()%>" name="Email">
                </div>
                <div class="form-group">
                    <label>Telefon</label>
                    <input type="text" id="phone" class="form-control" placeholder="Telefon" value="<%= kor.getTelefon()%>" name="Telefon">
                </div>
                <div class="form-group">
                    <label>Role</label>
                    <button type="button" class="list-group form-control" data-toggle="collapse" data-target="#role" style="font-weight: bold; padding-left: 40%">
                        Role
                    </button>
                    <div id="role" class="collapse">
                        <div class="form-check">
                            <label class="form-check-label">
                                <input 
                                    <%if (kor.getRola().equals("1")) {
                                            {%>checked ="checked" <%}
                                                }  %>
                                    name="Rola" value ="1" onclick="funkcija()"type="radio" class="btn btn-primary"> Korisnik
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input
                                    <%if (kor.getRola().equals("2")) {
                                            {%>checked ="checked" <%}
                                                }  %>
                                    name="Rola" value ="2" onclick="funkcija()" type="radio" class="btn btn-primary"> Administrator
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input
                                    <%if (kor.getRola().equals("3")) {
                                            {%>checked ="checked" <%}
                                                }  %>
                                    name="Rola" value ="3" type="radio" data-toggle="collapse" class ="btn btn-primary" data-target="#Demo" onclick="myFunction()"> Menadžer hotela
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <select id="showInDropDown" name="HotelId" class="form-control">
                        <option>Izaberite hotel </option>
                        <%
                            MenadzeriHotela menadzerHotela = new MenadzerHotelaRepo().select(kor.getId());
                            for (Hotel hotel : new HotelRepo().lista()) {
                                {%>
                        <option
                            <%
                                if (menadzerHotela.getKorisnikId() != null)
                                    if (menadzerHotela.getHotelId() == hotel.getHotelId()) {
                                        {%> selected <%}
                                                }%>
                            value="<%=hotel.getHotelId()%>">
                            <%=hotel.getIme()%> - <%=hotel.getDrzava()%> (<%=hotel.getAdresa()%>)</option>    
                            <%}
                                }
                            %>
                    </select>
                </div> 
            </div>
        </form> 
        <div class="col" style=" margin-top: 15px; margin-right: 2%">
            <div class="form-group">
                <label>Država</label>
                <input type="text" class="form-control" placeholder="Država" value="<%= kor.getDrzava()%>"  name="Drzava" form="promenaKorisnika">
            </div>
            <div class="form-group">
                <label>Grad</label>
                <input type="text" class="form-control" placeholder="Grad" value="<%= kor.getGrad()%>"  name="Grad" form="promenaKorisnika">
            </div>
            <div class="form-group">
                <label>Adresa</label>
                <input type="text" class="form-control" placeholder="Adresa" value="<%= kor.getAdresa()%>"  name="Adresa" form="promenaKorisnika">
            </div>
            <div class="form-group">
                <label>Poštanski broj</label>
                <input type="text" class="form-control" placeholder="Poštanski broj" value="<%= kor.getPostanskiBroj()%>" name="PostanskiBroj" form="promenaKorisnika">
            </div>
            <div class="form-group">
                <label>Poeni</label>
                <input type="text" class="form-control" placeholder="Poeni" value="<%= kor.getPoeni()%>"  name="Poeni" form="promenaKorisnika">
            </div>
            <div class="form-group">
                <a data-toggle="collapse" data-target="#passwordChange"><i class="far fa-file-edit fa-2x" style="margin-top: 13%"> Promena lozinke</i></a>
                <div id="passwordChange" class="collapse">
                    <label>Stara lozinka</label>
                    <input type="text" name="StaraLozinka" class="form-control" form="editPassword">
                    <div class="form-group">
                        <label>Nova lozinka</label>
                        <input type="text" name="NovaLozinka" class="form-control" form="editPassword">
                    </div>
                    <input type="submit" value="Promeni" class="btn btn-warning" style="color: white;" form="editPassword">
                </div>
            </div> 
        </div> 
        <input type="submit" value="Izmeni" class="btn btn-primary form-control" style="margin: 3% 5%" form="promenaKorisnika">
    </div>

    <form method="post" action="BrisanjeRezervacije">
        <center><a data-toggle="collapse"data-target="#tabela"><i onclick="izmeni(this)" id="myDIV" class="far fa-chevron-square-down  fa-3x" style="margin-top: 2%; margin-bottom: 2%;"> Vase rezervacije</i></a></center>
        <div id="tabela" class="collapse" style="width: 96%; margin-left: 2%;">
            <table id="Tabela" class="table table-hover table-dark" style="background: rgba(0,0,0,0.5); color:black; font-family: Roboto;">
                <thead style="font-size: 13px;">
                    <tr>
                        <th scope="col" class="text-center">#</th>
                        <th scope="col" class="text-center">Ime</th>
                        <th scope="col" class="text-center">Prezime</th>
                        <th scope="col" class="text-center">Datum dolaska</th>
                        <th scope="col" class="text-center">Datum odlaska</th>
                        <th scope="col" class="text-center">Vreme odlaska</th>
                        <th scope="col" class="text-center">Hotel</th>
                        <th scope="col" class="text-center">Broj sobe</th>
                        <th scope="col" class="text-center">Broj odraslih</th>
                        <th scope="col" class="text-center">Broj dece</th>
                        <th scope="col" class="text-center">Placeno novcem</th>
                        <th scope="col" class="text-center">Placeno poenima</th>
                        <th scope="col" class="text-center"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Korisnik korisnici = new KorisnikRepo().selectByUsername((String) request.getSession().getAttribute("ulogovan"));
                        String KorisnikId = request.getParameter("Korisnik_Id");
                        
                        int i = 1;
                        for (Rezervacija rezervacija : new RezervacijaRepo().lista()) {

                            if (Integer.parseInt(KorisnikId) == rezervacija.getKorisnikId()) {
                            {%>
                    <tr>
                        <td class="align-middle text-center"><%=i++%>  </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getIme()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getPrezime()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumDolaska()%></td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumOdlaska()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getVremeOdlaska()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.soba.Hotel.getIme()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.soba.getBrojSobe()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojOdraslih()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojDece()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getNovac()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getPoeni()%></td>
                        <td class="align-middle text-center"> 
                            <%
                                if (new RezervacijaRepo().aktivnaRezervacija(rezervacija.getId())) {
                            %>
                            <button disabled class="btn btn-success" style="font-weight: bold; height: 35px; width: 100px">AKTIVNA</button>
                            <% } else if (new RezervacijaRepo().isteklaRezervacija(rezervacija.getId())) {
                            %>
                            <button disabled class="btn btn-warning" style="font-weight: bold; color: white; height: 35px; width: 100px">ISTEKLA</button>

                            <%} else {
                            %>
                            <a class="delete_link btn btn-danger" style="font-weight: bold;  height: 35px; width: 100px" href="${pageContext.request.contextPath}/BrisanjeRezervacije?Rezervacije_Id=<%= rezervacija.getId()%>&Novac=<%=rezervacija.getNovac()%>&Poeni=<%=rezervacija.getPoeni()%>&Profil=True">
                                OTKAŽI                         
                            </a>
                            <%} %>
                        </td>
                    </tr>

                    <%}
                    } else if (kor.getRola().equals("1")) {
                        if (kor.getId() == rezervacija.getKorisnikId()) {
                            {%>
                    <tr>
                        <td class="align-middle text-center"><%=i++%>  </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getIme()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getPrezime()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumDolaska()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumOdlaska()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getVremeOdlaska()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.soba.Hotel.getIme()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.soba.getBrojSobe()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojOdraslih()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojDece()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getNovac()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getPoeni()%> </td>
                        <td class="align-middle text-center"> 
                            <%
                                if (new RezervacijaRepo().aktivnaRezervacija(rezervacija.getId())) {
                            %>
                            <button disabled="true" class="btn btn-success" style="font-weight: bold;  height: 35px; width: 100px"> AKTIVNA </button>
                            <% } else if (new RezervacijaRepo().isteklaRezervacija(rezervacija.getId())) { %>

                            <button disabled="true" class="btn btn-warning" style="font-weight: bold;  height: 35px; width: 100px"> ISTEKLA </button>

                            <% } else {%>

                            <a class="delete_link btn btn-danger" style="font-weight: bold;  height: 35px; width: 100px" href="${pageContext.request.contextPath}/BrisanjeRezervacije?Rezervacije_Id=<%= rezervacija.getId()%>&Novac=<%=rezervacija.getNovac()%>&Poeni=<%=rezervacija.getPoeni()%>&Profil=True">
                                OTKAŽI                              
                            </a>
                            <% } %>
                        </td>
                    </tr>
                    <%}
                                }
                            }
                        }
                    %>

                </tbody>
            </table>
        </div>
    </form>
    <script src="jQuery.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
        <script>
            $(document).ready(function(){
            $('#phone').mask('999-9999-999');
            });
        </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#Tabela').DataTable();
        });

        function myFunction() {
            document.getElementById("showInDropDown").style.visibility = "visible";
        }

        function funkcija() {
            document.getElementById("showInDropDown").style.visibility = "hidden";
        }

        function izmeni(x) {
            x.classList.toggle("fa-chevron-square-up");
        }

        function myFunc() {
            var element = document.getElementById("myDIV");
            element.classList.toggle("fa-chevron-square-up");
        }
    </script>
    <%
        String rezultat = (String) request.getAttribute("rezultat");

        if (rezultat != null)
        if (rezultat.equals("False")) {%>
    <script type="text/javascript">
        swal("Greška", "Uneli ste postojeće korisničko ime ili E-mail.", "error");
    </script>

    <%} %>
    <%
        String rezultat1 = (String) request.getAttribute("rezultat");
        if (rezultat1 != null)
            if (rezultat1.equals("true")) {%>
    <script type="text/javascript">
        swal("Uspeh", "Uspešno ste otkazali rezervaciju.", "success");
    </script>   
    <%} else if (rezultat1.equals("false")) {%>
    <script type="text/javascript">
        swal("Greska", "Pokušajte ponovo", "warning");
    </script>
    <%} %>
    <%
        if (request.getAttribute("Promena") != null)
            if (request.getAttribute("Promena").equals("True")) {%>
    <script type="text/javascript">
        swal("Uspeh", "Lozinka uspešno promenjena. ", "success");
    </script>
    <%}

        if (request.getAttribute("Promena") != null)
            if (request.getAttribute("Promena").equals("False")) {%>
    <script type="text/javascript">
        swal("Greška", "Uneta lozinka nije ispravna. ", "error");
    </script>
    <%}%>
    
</body>
</html>
