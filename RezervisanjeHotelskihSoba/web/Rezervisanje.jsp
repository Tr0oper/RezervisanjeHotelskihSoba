
<%@page import="RepoPattern.RezervacijaRepo"%>
<%@page import="Models.Rezervacija"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Soba"%>
<%@page import="RepoPattern.SobeRepo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rezerviši</title>
    </head>
    <style>
        label{
            font-weight: bold;
            color: whitesmoke;
        }
        #lista{
            background: rgba(0,0,0,0.5);
        }
        #lista:hover{
            background: rgba(0,0,0,0.7);
        }
    </style>
    <body>
        <%
            ArrayList<Rezervacija> aktivneRezervacije = new RezervacijaRepo().aktivneRezervacije(request.getParameter("Soba_Id"));
        %>
        
        <jsp:include page="navbar.jsp" />
        <br><br><br>
        <% int sobaMaxKapacitet = new SobeRepo().maxKapacitetSobe(request.getParameter("Soba_Id"));%>
       
        <form action = "KreiranjeRezervacije" method="post" style=" width: 782px; margin: 2% auto; background: rgba(0,0,0,0.5); border-radius: 5px">
            <% 
                String IDk = "";

                Soba soba = new SobeRepo().select(request.getParameter("Soba_Id"));
                if(request.getSession().getAttribute("UlogovanaRola")!=null)
                IDk = (String)request.getSession().getAttribute("UlogovanaRola");

            {%>
                <div class="card mb-3" style="background: rgba(0,0,0,0.5); color: white; width: 782px; display: inline-table; margin-bottom: 2%; border: solid black 1px; border-radius: 5px">
                    <center><div class="card-header"><b>Soba: <%=soba.getBrojSobe()%> - <%=soba.getTipSobe().getNaziv()%></b></div></center>
                    <img class="card-img-top" height="300px" width="780px" src="SlikeSoba.jsp?SobaId=<%=soba.getId()%>">
                        <div class="card-body">
                            <p>
                                Hotel: <%=soba.getHotel().getIme()%>
                                <span style="float: right; font-size: 16px; font-weight: bold"> Broj poena koje donosi: <%= soba.getPoeni() %></span>
                            </p>
                            <p>
                                Kratak opis: <%=soba.getKratkiOpis()%> <br>
                                Kapacitet: <%=soba.getKapacitet()%>
                            </p>
                            <p>
                                Opis: <%=soba.getOpis()%> 
                                <span style="float: right; font-size: 20px; font-weight: bold">Cena: <%=soba.getCena()%> €</span>
                            </p>
                            <input type="hidden" value="<%=soba.getCena()%>" name="CenaSobe">
                    </div>
                </div>
                <%} 
            %>

            <div class="row">
                <div class="col-3" style="margin-left: 2.5%">
                    <div class="form-group">
                    <label>Datum dolaska</label>
                    <input type="date" name="DatumDolaska" class="form-control" onkeydown="return false">
                    </div>
                    <div class="form-group">
                        <label>Datum odlaska</label>
                        <input type="date" name="DatumOdlaska" class="form-control" onkeydown="return false">
                    </div>
                    <div class="form-group">
                        <label>Vreme odlaska</label>
                        <input type="time" name="VremeOdlaska" class="form-control" onkeydown="return false">  <br> 
                        <input type="hidden" value="<%=request.getParameter("Soba_Id")%>" name="Soba_Id">
                    </div>
                </div>
                <div class="col-3">
                    <div class="form-group">
                        <label>Broj dece</label>
                        <select name="BrojDece" class="custom-select">
                           <% for(int i = 0; i <= sobaMaxKapacitet; i++){
                               {%>
                                  <option value="<%=i%>"> <%=i%> </option>
                               <%}  
                              }
                           %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Broj odraslih</label>
                        <select name="BrojOdraslih" class="custom-select">
                            <% for(int i = 0; i <= sobaMaxKapacitet; i++){
                                {%>
                                   <option value="<%=i%>"> <%=i%> </option>
                                <%}  
                               }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Idi na placanje" class="btn btn-success form-control" style="margin-top: 18.5%">
                    </div>
                </div>
                <div class="col-5">
                    <div class="list-group" style="margin-top: 10%; margin-left: 5%;">
                        <button type="button" class="list-group-item" data-toggle="collapse" data-target="#demo" style="font-weight: bold">
                            Datumi postojecih rezervacija
                        </button>
                       <div id="demo" class="collapse">
                        <% 
                            int brojac = 1;
                            for(Rezervacija rezervacija: aktivneRezervacije){ 
                                int godinaDolaska =Integer.parseInt(rezervacija.getDatumDolaska().substring(0, 4));
                                int mesecDolaska =Integer.parseInt( rezervacija.getDatumDolaska().substring(5, 7));
                                int danDolaska = Integer.parseInt(rezervacija.getDatumDolaska().substring(8, 10));

                                int godinaOdlaska =Integer.parseInt( rezervacija.getDatumOdlaska().substring(0, 4));
                                int mesecOdlaska = Integer.parseInt(rezervacija.getDatumOdlaska().substring(5, 7));
                                int danOdlaska =Integer.parseInt( rezervacija.getDatumOdlaska().substring(8, 10));
                                {%> 
                                    <button type="button" class="list-group-item list-group-item-action" id="lista" style="color: whitesmoke;"> 
                                    <%=brojac++%>. <%=danDolaska%>.<%=mesecDolaska%>.<%=godinaDolaska%> - <%=danOdlaska%>.<%=mesecOdlaska%>.
                                    <%=godinaOdlaska%> : <%=rezervacija.getVremeOdlaska()%> </button>
                                <%}                        
                            }
                        %>
                       </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
<%
    String rezultat =(String) request.getAttribute("Greska");

    if(rezultat!=null)
    if(rezultat.equals("False")){%>
    <script type="text/javascript">
        swal("Neispravno popunjeni podaci rezervacije", "Rezervacija nije uspela", "error")
        .then(function() {
        });

    </script> <%}       
 %>
            