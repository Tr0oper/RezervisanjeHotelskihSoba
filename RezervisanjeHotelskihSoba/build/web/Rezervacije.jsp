
<%@page import="java.util.ArrayList"%>
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page import="Models.Korisnik"%>
<%@page import="RepoPattern.RezervacijaRepo"%>
<%@page import="Models.Rezervacija"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="navbar.jsp" />  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rezervacije</title>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    </head>
    <style>
        label{
            color: whitesmoke;
        }
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
    </style>
    <body>
       <center><h4 style="color: whitesmoke; font-weight: bold; font-family: Roboto; margin-top: 2%; margin-bottom: 1% ">PREGLED REZERVACIJA </h4></center>
            <div style="width: 96%; margin-left: 2%;">
        <table id="Tabela" class="table table-hover table-dark" style="background: rgba(0,0,0,0.3); color:black; font-family: Roboto;">
            <thead style="font-size: 13px; background: rgba(0,0,0,0.5);">
                <tr>
                    <th scope="col" class="align-middle text-center">#</th>
                    <th scope="col" class="align-middle text-center">Ime</th>
                    <th scope="col" class="align-middle text-center">Prezime</th>
                    <th scope="col" class="align-middle text-center">Datum dolaska</th>
                    <th scope="col" class="align-middle text-center">Datum odlaska</th>
                    <th scope="col" class="align-middle text-center">Vreme odlaska</th>
                    <th scope="col" class="align-middle text-center">Hotel</th>
                    <th scope="col" class="align-middle text-center">Broj sobe</th>
                    <th scope="col" class="align-middle text-center">Broj odraslih</th>
                    <th scope="col" class="align-middle text-center">Broj dece</th>
                    <th scope="col" class="align-middle text-center">Novac</th>
                    <th scope="col" class="align-middle text-center">Cena u poenima</th>
                    <th scope="col" class="align-middle text-center"></th>
                </tr>
            </thead>
            <tbody>
            <%
                            Korisnik kor = new KorisnikRepo().selectByUsername((String) request.getSession().getAttribute("ulogovan"));

                            int i = 1;
                            ArrayList<Rezervacija> rezervacije;
                            if (kor.getRola().equals("2")) {
                                rezervacije = new RezervacijaRepo().lista();
                            } else {
                                rezervacije = new RezervacijaRepo().rezervacijeMenadzerovihHotela(kor.getId());
                            }

                            for (Rezervacija rezervacija : rezervacije) {
                                if (kor.getRola().equals("2") || kor.getRola().equals("3")) {
                                    {%>
                <tr style="">
                    <td class="align-middle text-center"><%= i++ %></td>
                    <td class="align-middle text-center"><%=rezervacija.klijent.getIme() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.klijent.getPrezime()%> </td>
                    <td class="align-middle text-center"><%=rezervacija.getDatumDolaska() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getDatumOdlaska() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getVremeOdlaska() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.soba.Hotel.getIme()%> </td>
                    <td class="align-middle text-center"><%=rezervacija.soba.getBrojSobe() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getBrojOdraslih() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getBrojDece() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getNovac() %> </td>
                    <td class="align-middle text-center"><%=rezervacija.getPoeni()%> </td>
                    <td class="align-middle text-center"> 
                        <% 
                           if(new RezervacijaRepo().aktivnaRezervacija(rezervacija.getId())){
                        %>
                        <button disabled class="btn btn-success" style="font-weight: bold; height: 35px; width: 100px">AKTIVNA</button>
                        <% }
                           else if(new RezervacijaRepo().isteklaRezervacija(rezervacija.getId())) { 
                        %>
                           <button disabled class="btn btn-warning" style="font-weight: bold; color: white; height: 35px; width: 100px">ISTEKLA</button>

                        <%} 
                           else{    
                        %>
                        <a class="delete_link btn btn-danger" style="font-weight: bold;  height: 35px; width: 100px" href="${pageContext.request.contextPath}/BrisanjeRezervacije?Rezervacije_Id=<%= rezervacija.getId()%>&Novac=<%=rezervacija.getNovac()%>&Poeni=<%=rezervacija.getPoeni()%>&Profil=False">
                            OTKAŽI                         
                        </a>
                        <%} %>
                    </td>
                </tr>
                 
             <%}
                }
                else if (kor.getRola().equals("1")){
                     if(kor.getId()==rezervacija.getKorisnikId()) {
                     {%>
                    <tr>
                        <td class="align-middle text-center"><%= kor.getRola()%>  </td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumDolaska() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.getDatumOdlaska() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.getNovac() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojOdraslih() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.getBrojDece() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.soba.getBrojSobe() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getIme() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.klijent.getPrezime()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getVremeOdlaska() %> </td>
                        <td class="align-middle text-center"><%=rezervacija.getPoeni()%> </td>
                        <td class="align-middle text-center"><%=rezervacija.getStatusRezervacije() %> </td>
                        <td class="align-middle text-center"> 
                         <% 
                            if(new RezervacijaRepo().aktivnaRezervacija(rezervacija.getId())){
                         %>
                         <button disabled="true" class="btn btn-success" style="font-weight: bold;  height: 35px; width: 100px"> AKTIVNA </button>
                         <% }
                            else if(new RezervacijaRepo().isteklaRezervacija(rezervacija.getId())) { 
                         %>
                            <button disabled="true" class="btn btn-warning" style="font-weight: bold;  height: 35px; width: 100px"> ISTEKLA </button>
                         
                         <%} 
                            else{    
                         %>
                         
                        <a class="delete_link btn btn-danger" style="font-weight: bold;  height: 35px; width: 100px" href="${pageContext.request.contextPath}/BrisanjeRezervacije?Rezervacije_Id=<%= rezervacija.getId()%>&Novac=<%=rezervacija.getNovac()%>&Poeni=<%=rezervacija.getPoeni()%>&Profil=False">
                            OTKAŽI                              
                        </a>
                         <%} %>
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
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"> </script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"> </script>
        <script type="text/javascript">
                $(document).ready( function () {
                 $('#Tabela').DataTable();
             } );
        </script>
    </body>
</html>
