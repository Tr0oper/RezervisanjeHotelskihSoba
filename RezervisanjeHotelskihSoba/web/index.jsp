
<%@page import="Models.Korisnik"%>
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page import="Controllers.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Početna</title>
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
    </style>
    <body>
        <%
            Boolean ulogovan= false;
            HttpSession sesija = request.getSession();
            if (sesija.getAttribute("ulogovan") != null) {
                ulogovan = true;
            }
        %>   
        <jsp:include page="navbar.jsp"/>  
        <br><br><br><br>

        <div style="width: 700px; margin: 0 auto; background: rgba(0,0,0,0.5); color: whitesmoke; text-align: center; border-radius: 7px">
            <h2>Web aplikacija za rezervisanje hotelskih soba</h2><br>
            <h5>Dobrodošli, drago nam je što koristite našu aplikaciju <i class="far fa-smile"></i> </h5><br>
            <a href="Hoteli.jsp" class="btn btn-sample"><i class="far fa-h-square"></i> Pregled hotela</a>
            
            <%
                if (!ulogovan) { %>
                    <a href="Registracija.jsp" class="btn btn-primary" style="margin-left: 15px"><i class="fas fa-user-plus"></i> Sign Up </a>
                    <button type="button" style="margin-left: 15px" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                        Log In <i class="fas fa-sign-in-alt"></i>
                    </button>
            <% } 
                else { %>
                <a class="btn btn-warning" style="color: whitesmoke; margin-left: 15px" href="Logout">Log Out <i class="fas fa-sign-out-alt"></i></a>
                <% } %>
            <br><br>
            <h5 style="padding-bottom: 5px"><i class="fal fa-copyright"></i> Autor: Pavle Lukić</h5>
        </div>
         
        <%
        String Ime =(String) request.getSession().getAttribute("ulogovan");
        if(request.getAttribute("prvoLogovanje")!=null)
        if(request.getAttribute("prvoLogovanje").equals("True")){%>
        <script type="text/javascript">
            swal("Dobrodošli  <%=Ime %>!", "Uspešno ste se ulogovali! ", "success")
                .then(function() {
                    <% request.removeAttribute("prvoLogovanje"); %>
                    window.location = "Hoteli.jsp";

                });

        </script>
         <%   }

         if(request.getAttribute("prvoLogovanje")!=null)
         if(request.getAttribute("prvoLogovanje").equals("False")) {%>
            <script type="text/javascript">
                $(window).on('load',function(){
                    $('#exampleModal').modal('show');
                });
            </script>
        <%}

        %>
            
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                            <input type="submit" id="LogInGlavni" class="btn btn-primary">Log In</button>
                        </div>
                    </form>
            </div>
        </div>
    </div>
        
</body>
</html>
