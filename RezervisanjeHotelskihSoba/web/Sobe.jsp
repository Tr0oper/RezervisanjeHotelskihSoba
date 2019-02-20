
<%@page import="RepoPattern.SobeRepo"%>
<%@page import="Models.Soba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="navbar.jsp" /> 
       
        <%

            String hotelIdSesija = "" + request.getSession().getAttribute("HotelId");

            String Hotel_Id = request.getParameter("Hotel_Id");

            if (Hotel_Id == null) {
                response.sendRedirect("Hoteli.jsp");
            }
        %>
        <center>
            <input type="text" id="myInput" onkeyup="myFunction()" style="width:250px;" placeholder="Pretraga soba.." class="form-control"><br>
        </center>
        <%
            String ulogovanaRola = "";
            if ((String) request.getSession().getAttribute("UlogovanaRola") != null) {
                ulogovanaRola = (String) request.getSession().getAttribute("UlogovanaRola");
            }
            if (ulogovanaRola.equals("2") || Hotel_Id.equals(hotelIdSesija)) {
        %>
        <center><a style="width: 250px" href="${pageContext.request.contextPath}/KreiranjeSoba.jsp?Hotel_Id=<%=Hotel_Id%>" class="btn btn-success">Dodaj novu sobu</a></center><br>
        
            <% }
                String IDk = "";

                if (request.getSession().getAttribute("UlogovanaRola") != null) {
                    IDk = (String) request.getSession().getAttribute("UlogovanaRola");
                }
           
            %>
            <ul id="myUL" class="list-unstyled">
            <div class="card-group"> <%
           
                for (Soba soba : new SobeRepo().listaSobaIzabranogHotela(Hotel_Id)) {
                    {%>
                    <li class="list-unstyled">
                        <div class="card" style="background: rgba(0,0,0,0.5); color: whitesmoke;   width: 288px; width: 287px;  margin-bottom: 25px; margin-left: 25px;  border: solid black 1px; border-radius: 5px">
                            <center><div class="card-header">Soba broj: <b><%=soba.getBrojSobe()%></b></div></center>
                            <img height="180px" width="286px" src="SlikeSoba.jsp?SobaId=<%=soba.getId()%>" />  
                            <div class="card-body">
                                <a>
                                    <p class="card-text">
                                        Hotel: <%=soba.getHotel().getIme()%><br>
                                        Tip sobe: <%=soba.getTipSobe().getNaziv()%> <br>
                                        Kratak opis: <%=soba.getKratkiOpis()%> <br>
                                        Cena: <%=soba.getCena()%> € <br>
                                        Cena u poenima: <%=soba.getCenaUPoenima()%><br>
                                        Broj poena: <%=soba.getPoeni()%> <br>
                                        Kapacitet: <%=soba.getKapacitet()%> 
                                        <span style="visibility: hidden"><%=soba.getBrojSobe()%></span>
                                    </p>
                                </a><br>
                                
                                <p class="card-text">Opis: <%=soba.getOpis()%></p>
                            </div>  
                            <div class="card-footer">
                                <% if(!IDk.isEmpty()) { %>
                                    <center> <a href="${pageContext.request.contextPath}/Rezervisanje.jsp?Soba_Id=<%=soba.getId()%>" class="btn btn-warning" style=" color: whitesmoke; background-color: #efaf14; width: 47%">Rezerviši</a>
                                <% } %>

                                <% 
                                    if (IDk.equals("2") || Hotel_Id.equals(hotelIdSesija)) {%> 
                                    <a href="${pageContext.request.contextPath}/PromenaSoba.jsp?Soba_Id=<%=soba.getId()%>" class="btn btn-primary" style="width: 47%; margin-left: 10px">Izmeni</a></center>
                                    <%}
                                %>
                            </div>
                        </div>
                    </li>
                    <%}
                }
            %>
       </div>
       </ul>
    </body>
</html>
<script>
    function myFunction() {
        // Declare variables
        var input, filter, ul, li, a, i, txtValue;
        input = document.getElementById('myInput');
        filter = input.value.toUpperCase();
        ul = document.getElementById("myUL");
        li = ul.getElementsByTagName('li');

        // Loop through all list items, and hide those who don't match the search query
        for (i = 0; i < li.length; i++) {
            a = li[i].getElementsByTagName("a")[0];
            txtValue = a.textContent || a.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";
            }
        }
    }
</script>