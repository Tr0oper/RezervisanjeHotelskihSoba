
<%@page import="java.util.ArrayList"%>
<%@page import="RepoPattern.HotelRepo"%>
<%@page import="Models.Hotel"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hoteli</title>
    </head>
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
        .zoom:hover {
            transform: scale(1.75);
            z-index:10;
        }

    </style>
    <body>
        <jsp:include page="navbar.jsp" />
        
    <center>
        <input type="text" id="myInput" onkeyup="myFunction()" style="width:250px;" placeholder="Pretraga hotela " class="form-control"><br>
    </center>

    <%
        String UlogovanaRola = "";
        if (request.getSession().getAttribute("UlogovanaRola") != null) {
            UlogovanaRola = "" + (request.getSession().getAttribute("UlogovanaRola"));
        }

        if (UlogovanaRola != null)
            if (UlogovanaRola.equals("2")) {%>
    <center><a href="KreiranjeHotela.jsp" class="btn btn-success" style="width:250px;">Dodaj novi hotel</a></center><br>
        <%}

        %>
    
    <ul id="myUL" class="list-unstyled">
        <div class="card-group">
            
            <%
            for (Hotel hotel : new HotelRepo().lista()) {
                {%>

            <li>
                <div class="card" style="background: rgba(0,0,0,0.5); color: whitesmoke; width: 287px;  margin-bottom: 25px; margin-left: 25px;  border: solid black 1px; border-radius: 5px">  
                    <center><div class="card-header"><b><%= hotel.getIme()%></b></div></center>
                    <div class="zoom">
                        <img height="180px" width="285px" src="SlikeHotela.jsp?hotelID=<%=hotel.getHotelId()%>" />
                    </div>
                    <div class="card-body">
                        <a><p class="card-text">
                                Država: <%=hotel.getDrzava()%><br>
                                Grad: <%=hotel.getGrad()%><br>
                                Adresa: <%=hotel.getAdresa()%>
                                <span style="visibility: hidden; font-size: 0px"><%= hotel.getIme()%></span>
                                <span style="visibility: hidden; font-size: 0px""><%=hotel.getBrojZvezdica()%></span></p></a>
                        <p class="card-text" style="margin-top: 5%"> Opis: <%=hotel.getOpis()%></p>

                        <%
                            int x = hotel.getBrojZvezdica();
                            for (int i = 0; i < x; i++) {%>
                        <i class="fas fa-star" style="color:#f2d202"></i>
                        <%}
                                if (x == 4) {%>
                        <i class="fas fa-star"></i>
                        <%}
                                if (x == 3) {%>
                        <i class="fas fa-star"></i> <i class="fas fa-star"></i>
                        <%}
                                if (x == 2) {%>
                        <i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"> </i>
                        <%}
                                if (x == 1) {%>
                        <i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i> <i class="fas fa-star"></i>
                        <%}
                        %>
                    </div>

                    <div class="card-footer" style="margin-left: -5px; margin-right: -5px">

                        <center><a href="${pageContext.request.contextPath}/Sobe.jsp?Hotel_Id=<%=hotel.getHotelId()%>" class="btn btn-sample">Pogledaj sobe</a>

                            <% if (UlogovanaRola.equals("2")) {%> 
                            <a href="${pageContext.request.contextPath}/PromenaHotela.jsp?Hotel_Id=<%=hotel.getHotelId()%>" class="btn btn-primary" style="width: 47%; margin-left: 5px">Izmeni</a></center>
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
</body>
</html>
