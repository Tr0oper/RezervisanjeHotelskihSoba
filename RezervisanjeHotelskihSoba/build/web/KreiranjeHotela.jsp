
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hoteli</title>
    </head>
    <style>
        label{
            color: white;
            font-weight: bold;
        }
        .invalid-feedback{
            font-weight: bold;
        }
    </style>
    <body>
        <jsp:include page="navbar.jsp" />
        <br><br><br>
        <%
            if(request.getSession().getAttribute("UlogovanaRola")!=null){
               if(!(request.getSession().getAttribute("UlogovanaRola").equals("2")))
                      response.sendRedirect("index.jsp");
            }
            else
                response.sendRedirect("index.jsp");
        %>
        
        <center><h4 style="color: white; font-weight: bold; margin-top: 2%">KREIRANJE NOVOG HOTELA</h4></center>
        
        <form action = "KreiranjeHotela" method="post" enctype="multipart/form-data" style="width: 450px; margin: 2% auto" class="main-form needs-validation" novalidate>
            <div class="row" style=" background: rgba(0, 0, 0, 0.5); border-radius: 7px;">
                <div class="col-9" style="margin: 2% auto">
                    <div class="form-group">
                        <label>Ime </label>
                        <input class="form-control" placeholder="Ime hotela" type="text" name="Naziv" required>
                        <div class="invalid-feedback">Unesite ime hotela!</div>
                    </div>
                    <div class="form-group">
                        <label>Država </label>
                        <input class="form-control" type="text" placeholder="Država" name="Drzava" required>
                        <div class="invalid-feedback">Unesite državu!</div>
                    </div>
                    <div class="form-group">
                        <label>Grad </label>
                        <input class="form-control" type="text" placeholder="Grad" name="Grad" required>
                        <div class="invalid-feedback">Unesite grad!</div>
                    </div>
                    <div class="form-group">
                        <label>Adresa </label>
                        <input class="form-control" type="text" placeholder="Adresa" name="Adresa" required>
                        <div class="invalid-feedback">Unesite adresu!</div>
                    </div>
                    <div class="form-group">
                        <label>Broj zvezdica </label>
                        <input class="form-control" id="stars" type="text" placeholder="Broj zvezdica" name="Zvezdice" required>
                        <div class="invalid-feedback">Unesite broj zvezdica!</div>
                    </div>
                    <div class="form-group">
                        <label>Opis </label>
                        <input class="form-control" type="text" placeholder="Opis" name="Opis" required>
                        <div class="invalid-feedback">Unesite opis!</div>
                    </div>
                    <div class="form-group">
                        <label>Slika </label>
                        <input class="form-control-file" type="file" name="file" id="profile-img" style="color:white;" required>
                        <img src="" id="profile-img-tag" width="286px" />
                        <div class="invalid-feedback">Odaberite neku sliku!</div>
                    </div>
                    <div class="form-group">
                        <input class="btn btn-success form-control" type="submit" value="Kreiraj hotel" style="margin-top: 1.5%">
                    </div>
                </div>
            </div>
        </form>
    <script>
        var form = document.querySelector('.needs-validation');
        form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });

        function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#profile-img-tag').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
            }
        }
        $("#profile-img").change(function(){
            readURL(this);
        });
    </script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
        <script>
            $(document).ready(function(){
            $('#stars').mask('9');
            });
        </script>
    </body>
</html>