
<%@page import="RepoPattern.TipSobeRepo"%>
<%@page import="Models.TipSobe"%>
<%@page import="RepoPattern.SobeRepo"%>
<%@page import="Models.Soba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        label{
            color: white;
            font-weight: bold
        }
    </style>
    <body>
        <jsp:include page="navbar.jsp" />  
        <br><br><br>
        <% 
            Soba soba = new SobeRepo().select(request.getParameter("Soba_Id"));
            
            
            //izmeni ovo da bude preko sesije ne ovako
            //Klijent klijent = (Klijent)request.getAttribute("Klijent");
            
           // String Rola = "";
           // if (klijent.getRola().equals("1"))
            //    Rola = "Klijent";
           // else if(klijent.getRola().equals("2"))
            //    Rola = "Administrator";
            //else
              //  Rola = "Menadžer hotela";
        %>
        
        <center><h4 style="color: white ; font-weight: bold; margin-top: 15px">IZMENA PODATAKA O SOBI: <%= soba.getBrojSobe() %></h4></center>
        
        <form action="PromenaSoba" method="post" enctype="multipart/form-data" style="width: 800px; margin: 2% auto">
            <input value="<%=request.getParameter("Soba_Id")%>" name="Soba_Id" type="hidden">
            <input value="<%=request.getParameter("Hotel_Id")%>" name="Hotel_Id" type="hidden">
                <div class="row" style=" background: rgba(0, 0, 0, 0.5); border-radius: 7px;">
                    <div class="col " style="margin-top: 15px">
                        <div class="form-group">
                            <label>Broj sobe</label>
                            <input type="text" class="form-control" placeholder="Broj sobe" value="<%=soba.getBrojSobe()%>" name="BrojSobe">
                        </div>
                        <div class="form-group">
                            <label>Tip Sobe</label>
                            <select name="TipSobe" class="form-control">
                            <option value="<%=soba.getTipSobeID() %>"><%=soba.TipSobe.getNaziv()%></option> 
                            <%
                               for(TipSobe tipSobe: new TipSobeRepo().lista(Integer.toString(soba.getHotelID()))){ 
                                   if(!(soba.TipSobe.getNaziv().equals(tipSobe.getNaziv())))   
                                    {%> <option value="<%=tipSobe.getId() %>"><%=tipSobe.getNaziv()%></option> <%}
                               }
                            %> 
                            </select> 
                        </div>
                        <div class="form-group">
                            <label>Kratak opis</label>
                            <input type="text" class="form-control" placeholder="KratkiOpis" value="<%= soba.getKratkiOpis() %>"  name="KratkiOpis">
                        </div>
                        <div class="form-group">
                        <label>Kapacitet</label>
                        <input type="text" class="form-control" placeholder="Kapacitet" value="<%= soba.getKapacitet()%>"  name="Kapacitet">
                        </div>
                    </div>
                    <div class="col" style="margin-top: 15px">
                        <div class="form-group">
                            <label>Opis</label>
                            <input type="text" class="form-control" placeholder="Opis" value="<%= soba.getOpis()  %>"  name="Opis">
                        </div>
                        <div class="form-group">
                            <label>Cena</label>
                            <input type="text" class="form-control" placeholder="Cena" value="<%= soba.getCena()%>"  name="Cena">
                        </div>
                        <div class="form-group">
                            <label>Cena u poenima</label>
                            <input type="text" class="form-control" placeholder="Cena sa poenima" value="<%= soba.getCenaUPoenima()%>"  name="CenaUPoenima">
                        </div>
                        <div class="form-group">
                            <label>Poeni</label>
                            <input type="text" class="form-control" placeholder="Poeni" value="<%= soba.getPoeni()%>"  name="Poeni">
                        </div>
                    </div>
                    <div class="col" style="margin-top: 15px">
                        <div class="form-group">
                            <label>Slika</label>
                            <img height="180px" width="286px" src="SlikeSoba.jsp?SobaId=<%=request.getParameter("Soba_Id")%>" /> 
                            <input type="file" class="form-control-file" value="<%= soba.getSlika()%>" id="slika-sobe" name="file" style="color:white;"></td>
                            <img src="" id="slika-sobe-nova" width="286px"/>
                        </div>
                        <input type="submit" value ="Izmeni" class="btn btn-primary" style="margin-top: 2.8%; margin-bottom: 5%; width: 47%; margin-right: 3%">
                        <form action="BrisanjeHotela" method="post">
                            <a class="btn btn-danger" href="${pageContext.request.contextPath}/BrisanjeSoba?Soba_Id=<%=request.getParameter("Soba_Id")%>" style="margin-top: 2.8%; width: 47%; margin-bottom: 5%"> 
                                Obriši
                            </a>
                        </form>
                    </div>
                </div>
            </form>
        <script type="text/javascript">
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#slika-sobe-nova').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#slika-sobe").change(function(){
                readURL(this);
            });
        </script>
    </body>
</html>
