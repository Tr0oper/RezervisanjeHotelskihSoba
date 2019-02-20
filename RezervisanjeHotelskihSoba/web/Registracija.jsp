
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr">
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
       label{
            font-weight: bold;
            color: white;
        }
        .invalid-feedback{
            font-weight: bold;
        }
    </style>
    <body>
        <% 
            HttpSession sesija = request.getSession();
            
            if(sesija.getAttribute("ulogovan")!=null)
                response.sendRedirect("index.jsp");
        %>
        <jsp:include page="navbar.jsp" /> 
        <br>
        <center><h4 style="color: white; font-weight: bold; margin-top: 15px">REGISTRACIJA</h4></center>
        <form action="KlijentController" style="width: 450px; margin: 2% auto;" class="main-form needs-validation"  novalidate>
            <div style="background: rgba(0, 0, 0, 0.5); border-radius: 7px; padding:15px;">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label>Ime</label>
                            <input type="text" name="Ime" class="form-control" minlength="3" placeholder="Ime" required>
                            <div class="invalid-feedback">Unesite ime! (Minimum 3 karaktera)</div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>Prezime</label>
                            <input type="text" name="Prezime" class="form-control" placeholder="Prezime" required>
                            <div class="invalid-feedback">Unesite prezime!</div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="KIme" class="form-control" placeholder="Username" required>
                    <div class="invalid-feedback">Unesite username!</div>

                    <label>Password</label>
                    <input type="text" name="Lozinka" id="password" class="form-control" placeholder="Password" required>
                    <div class="invalid-feedback">Unesite password!</div>

                    <label>Email</label>
                    <input type="mail" name="Email" class="form-control" placeholder="E-mail" required>
                    <div class="invalid-feedback">Unesite Email!</div>
                </div>
                <div class="form-group">
                    <label>Telefon</label>
                    <input type="text" id="phone" title="e.g (123) 456-7890"  name="Telefon" minlength="6" class="form-control item"  placeholder="Telefon   npr(066-1234-567)" required>
                    <div class="invalid-feedback">Unesite telefon! (Minimalana dužina 6 brojeva)</div>
                    
                <div class="row">
                    <div class="col">
                        <label>Država</label>
                        <input type="text" name="Drzava" class="form-control" placeholder="Država" required>
                        <div class="invalid-feedback">Unesite državu!</div>
                    </div>
                    <div class="col">
                        <label>Grad</label>
                        <input type="text" name="Grad" class="form-control" placeholder="Grad" required>
                        <div class="invalid-feedback">Unesite grad!</div>
                    </div>
                </div>
                    <label>Adresa</label>
                    <input type="text" name="Adresa" class="form-control" placeholder="Adresa" required>
                    <div class="invalid-feedback">Unesite adresu!</div>

                    <label>Poštanski broj</label>
                    <input type="text" name="PostanskiBroj" class="form-control"  placeholder="Poštanski broj" required>
                    <div class="invalid-feedback">Unesite poštanski broj!</div>
                </div>
                <center style="margin-top: 20px">
                    <input type="submit" value="Registruj se" class="btn btn-primary" style="width: 420px;">
                </center>
            </div>
        </form>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
        <script>
            $(document).ready(function(){
            $('#phone').mask('999-9999-999');
            });
        </script>
        
    <%
        String rezultat =(String) request.getAttribute("rezultat");

        if(rezultat!=null)
        if(rezultat.equals("True")){%>
        <script type="text/javascript">
                swal("Dobar  posao", "Registracija uspela", "success")
                .then(function() {
                    window.location = "index.jsp";
                });
        </script>

                 <%   }

        else if (rezultat.equals("False"))  {%>

               <script type="text/javascript">
                    swal("Greška", "Uneli ste postojeće korisničko ime ili E-mail.", "error")
                   .then(function() {
                       window.location = "Registracija.jsp";
                   });
               </script>

    <% }%>
    <script>
        var form = document.querySelector('.needs-validation');
        form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
        
    </script>
    </body>
</html>

