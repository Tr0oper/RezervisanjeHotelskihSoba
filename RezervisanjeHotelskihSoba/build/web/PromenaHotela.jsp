
<%@page import="RepoPattern.MenadzerHotelaRepo"%>
<%@page import="Models.MenadzeriHotela"%>
<%@page import="RepoPattern.TipSobeRepo"%>
<%@page import="Models.TipSobe"%>
<%@page import="Models.Hotel"%>
<%@page import="RepoPattern.HotelRepo"%>
<%@page import="Models.Korisnik"%>
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        label{
            color: whitesmoke;
            font-weight: bold;
        }
        .vl {
            border-left: 2px solid black;}
        </style>
        <style>
        .btn-sample { 
            color: #ffffff; 
            background-color: #611BBD; 
            border-color: #130269; 
        } 
        .btn-sample:hover{
            color: #ffffff;
            background-color: #49247A;     
        }
    </style>
    <body>
        <jsp:include page="navbar.jsp"/>  
        <br><br><br>
        <% 
            String HotelID = request.getParameter("Hotel_Id");
            Hotel hotel = new HotelRepo().select(HotelID);
            
            boolean pristupSvomHotelu = true;
            
            if(request.getSession().getAttribute("UlogovanaRola")!=null)
               if(request.getSession().getAttribute("UlogovanaRola").equals("3")) 
                      pristupSvomHotelu = new MenadzerHotelaRepo().pristup(HotelID, ""+request.getSession().getAttribute("HotelId"));
            
            
            if(request.getSession().getAttribute("UlogovanaRola")!=null){
               if((request.getSession().getAttribute("UlogovanaRola").equals("1")) 
                       || !(pristupSvomHotelu))
                      response.sendRedirect("index.jsp");
            }
            else
                response.sendRedirect("index.jsp");

        %>
        
        <center><h4 style="color: whitesmoke; font-weight: bold; margin-top: 1.5%">IZMENA PODATAKA O HOTELU: <%= hotel.getIme()%></h4></center>
        
        <form id="forma" action="PromenaHotela" method="post" enctype="multipart/form-data" style="width: 950px; margin: 2% auto">
            <input value="<%=request.getParameter("Hotel_Id")%>" name="Hotel_Id" type="hidden">
                <div class="row" style=" background: rgba(0, 0, 0, 0.5); border-radius: 7px;">
                    <div class="col " style="margin-top: 15px">
                        <div class="form-group">
                            <label>Ime</label>
                            <input type="text" name="Naziv" value="<%=hotel.getIme() %>" placeholder="Ime hotela" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Država</label>
                            <input type="text" name="Drzava" value="<%=hotel.getDrzava()%>" placeholder="Država" class="form-control">
                        </div>
                        <div class="form-group">
                        <label>Grad</label>
                        <input type="text" class="form-control" placeholder="Grad" value="<%= hotel.getGrad()%>"  name="Grad">
                        </div>
                        <div class="form-group">
                            <label>Adresa</label>
                            <input type="text" class="form-control" placeholder="Adresa" value="<%= hotel.getAdresa()%>" name="Adresa">
                        </div>
                        <div class="form-group">
                            <label>Opis</label>
                            <input type="text" class="form-control" placeholder="Opis" value="<%= hotel.getOpis()%>" name="Opis">
                        </div>
                    </div>
                    <div class="col" style="margin-top: 15px">
                        <div class="form-group">
                            <label>Broj zvezdica</label>
                            <input type="text" name="Zvezdice" value="<%=hotel.getBrojZvezdica()%>" placeholder="Broj zvezdica" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Slika</label>
                            <img height="180px" width="286px" src="SlikeHotela.jsp?hotelID=<%=hotel.getHotelId()%>" /> 
                            <input type="file" class="form-control-file" placeholder="Slika" value="<%= hotel.getSlika()%>" id="slika-hotela" name="file" style="color:whitesmoke">
                            <img src="" id="slika-hotela-nova" width="286px"/>
                        </div>
                        <div class="form-check">
                            <div class="row">
                                <div class="col" style="margin-left: -3%; margin-top: 2.5%">
                                    <input form="forma" type="submit" value ="Izmeni" class="btn btn-primary" style="  width: 125px; margin-right:10px;" form="forma">
                                
                                    <form action="BrisanjeHotela" method="post">
                                        <a class="delete_link btn btn-danger" href="${pageContext.request.contextPath}/BrisanjeHotela?Hotel_Id=<%=HotelID%>"  style=" width: 125px;">
                                            Obriši                             
                                        </a>
                                    </form> 
                                </div>
                            </div>
                            <% if(request.getSession().getAttribute("UlogovanaRola").equals("3")) { %>
                                <center><a href="Sobe.jsp?Hotel_Id=<%= request.getSession().getAttribute("HotelId") %>" class="btn btn-sample" style="width: 265px; margin-top:5%; margin-bottom: 5%; margin-left: -31px">Sobe hotela</a></center> 
                            <% } %>
                        </div>
                    </div>
                    </form>
                    <div class="vl"></div> 
                    <div class="col" style="margin-top: 15px">
                        <form action="KreiranjeTipaSoba" method="post">
                        <center><h5 style=" color: whitesmoke; font-weight: bold; margin-top: 3.3%">KREIRAJ NOVI TIP SOBE ZA OVAJ HOTEL</h5></center>
                        <input value="<%= request.getParameter("Hotel_Id")%>" name="Hotel_Id" type="hidden">
                        <div class="form-group">
                            <label>Tip</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Tip sobe" name="Naziv">
                                <div class="input-group-append">
                                    <input type="submit" value="Kreiraj" class="btn btn-success" style="margin-bottom: 5%">
                                </div>
                            </div>
                        </div>
                    </form>
                    <form action="BrisanjeTipovaSoba" method="post">
                        <input value="<%= request.getParameter("Hotel_Id")%>" name="Hotel_Id" type="hidden">
                        <%for (TipSobe tipSobe : new TipSobeRepo().lista(HotelID)) {
                            {%>   
                                <div class="input-group" style="margin-bottom: 3%">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <input type="checkbox" name="TipSobe" value="<%=tipSobe.getId()%>">
                                        </div>
                                    </div>
                                            <input type="text" readonly class="form-control" value="<%=tipSobe.getNaziv()%>">
                                </div>
                            <%} } %>
                        <input type="submit" style="float:left;" value ="Obriši"  class="btn btn-danger">
                    </form>
                    </div>
                </div>
        
    <script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#slika-hotela-nova').attr('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
        $("#slika-hotela").change(function () {
            readURL(this);
        });
    </script>
    </body>
</html>