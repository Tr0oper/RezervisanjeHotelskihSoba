
<%@page import="Models.Korisnik"%>
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="sr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.1.0/css/all.css">
    </head>
    <style>
        .background-image {
            position: fixed;
            background-image: url( 'https://fr.cdn.v5.futura-sciences.com/buildsv6/images/largeoriginal/c/a/a/caa7ada7d5_73511_mteverest-drukair2.jpg' );
            background-repeat: no-repeat;
            background-size: cover;
            width: 100%;
            height: 100%;
            z-index: -1;
            filter: blur(7px);
        }
    </style>
    <div class="background-image"></div>
        <%
            Boolean pom = false;
            HttpSession sesija = request.getSession();
            if (sesija.getAttribute("ulogovan") != null) {
                pom = true;
            }
        %>                 
        <nav class="navbar navbar-expand-lg sticky-top navbar-dark" style="background: rgba(0,0,0,0.9)">
           
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                     <li class="nav-item">
                         <a class="nav-link" href="index.jsp"><i class="fas fa-bed fa-2x"></i></a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="Hoteli.jsp"><i class="far fa-h-square fa-lg"></i> Hoteli <span class="sr-only">(current)</span></a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <%
                        if (!pom) {%>

                    <li class="nav-item"><a class="nav-link" href="Registracija.jsp"><i class="fas fa-user-plus fa-lg"></i> Sign Up</a></li>
                    <li class="nav-item"><a class="nav-link" href="" data-toggle="modal" data-target="#exampleModal" >Log In <i class="fas fa-sign-in-alt fa-lg"></i></a></li>


                    <%   } else {%>
                    <li class="nav-item"><a class="nav-link" href="Logout">Log Out <i class="fas fa-sign-out-alt"></i></a></li>
                        <%   }
                        %>

           
                                
            <%
            if (request.getSession().getAttribute("ulogovan") != null) {%>

            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/PromenaKorisnika.jsp?Korisnik_Id=<%=new KorisnikRepo().selectByUsername(""+(request.getSession().getAttribute("ulogovan"))).getId() %>"><i class="fas fa-user"></i> Profil</a>
            </li> 
            <%}
            %>
            <%if (pom) {%>
            
            

            <%
                String ulogovanaRola = "";
                  if (request.getSession().getAttribute("ulogovan") != null) {
                    ulogovanaRola = "" + request.getSession().getAttribute("UlogovanaRola");
                }

                if (ulogovanaRola.equals("2") || ulogovanaRola.equals("3")) {
            %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle"  href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fal fa-sliders-h"></i> Dodatne opcije
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">

                    <%
                        if (ulogovanaRola.equals("2")) {
                            {%> 
                            <a class="dropdown-item" href="Korisnici.jsp" ><i class="fas fa-users "></i> Svi korisnici</a>
                    
                    <%}
                        }
                        if (ulogovanaRola.equals("3")) {
                            {%> 
                            <a class="dropdown-item" href="PromenaHotela.jsp?Hotel_Id=<%= request.getSession().getAttribute("HotelId") %>"><i class="fas fa-wrench"></i> Upravljanje hotelom</a>
                    <%}
                        }
                    %>
                    <a class="dropdown-item" href="Rezervacije.jsp"><i class="fas fa-list "></i> Sve rezervacije</a>
                    <% } %>
                </div>
            </li>
            
            <% }
            %>
            <ul class="navbar-nav">
             <li class="nav-item">
                <%  String brojPoenaKorisnika = "0";
                    if(request.getSession().getAttribute("BrojPoenaKorisnika")!=null)
                       brojPoenaKorisnika = "" + request.getSession().getAttribute("BrojPoenaKorisnika"); %>
                <a class="nav-link" href="#"><i class="fal fa-coins fa-lg"></i> Broj poena: <%=brojPoenaKorisnika%></a>
            </li>
            </ul>
        </div>
    </nav>
             <!-- Modal -->
             <div class="modal fade" style="margin-top: 100px"id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel">Log In</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <form action="Login" method="post">
                            <div class="modal-body">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1" for="validationServer03"><i class="fas fa-user"></i> </span>
                                    </div>
                                    <input required name="username" type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1"><i class="fas fa-lock"></i></span>
                                    </div>
                                    <input required name="password" type="password" class="form-control" placeholder="Password" aria-label="Password" aria-describedby="basic-addon1">
                                    
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Log In</button>
                        </div>
                             </form>
                    </div>
                </div>
            </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</body>
</html>