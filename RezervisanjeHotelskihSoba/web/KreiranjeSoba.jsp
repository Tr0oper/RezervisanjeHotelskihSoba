
<%@page import="RepoPattern.HotelRepo"%>
<%@page import="Models.Hotel"%>
<%@page import="Models.TipSobe"%>
<%@page import="RepoPattern.TipSobeRepo"%>
<%@page import="Models.Soba"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        label{
            font-weight: bold;
            color: whitesmoke;
        }
        .invalid-feedback{
            font-weight: bold;
        }
    </style>
    <body>
        <jsp:include page="navbar.jsp" />
        <br><br><br>
         <% 
            String HotelID = request.getParameter("Hotel_Id");
            ArrayList<TipSobe> tipoviSoba = new TipSobeRepo().lista(HotelID);             
            Hotel hotel = new HotelRepo().select(HotelID);
         %>
         
        <center><h4 style="color: white; font-weight: bold; margin-top: 2%">KREIRANJE SOBE ZA HOTEL: <%= hotel.getIme()%></h4></center>
         
        <form action = "KreiranjeSoba" method="post" enctype="multipart/form-data" style="width: 450px; margin: 2% auto" class="main-form needs-validation" novalidate>
            <input value="<%=hotel.getHotelId()%>" name="Hotel_Id" type="hidden">
            <div class="row" style=" background: rgba(0, 0, 0, 0.5); border-radius: 7px;">
                <div class="col-10" style="margin: 2% auto">
                    <div class="form-group">
                        <label>Broj sobe</label>
                        <input type="text" placeholder="Broj sobe" class="form-control" name="BrojSobe" required>
                        <div class="invalid-feedback">Unesite broj sobe!</div>
                    </div>
                    <div class="form-group">
                        <label>Tip sobe</label>
                        <select name="TipSobe" class="form-control" required>
                            <%
                               for(TipSobe tipSobe:tipoviSoba){
                                   {%> 
                                       <option value="<%=tipSobe.getId()%>"><%=tipSobe.getNaziv()%></option>
                                   <%}
                               }
                            %> 
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Opis</label>
                        <input type="text" placeholder="Opis" class="form-control" name="Opis" required>
                        <div class="invalid-feedback">Unesite opis!</div>
                    </div>
                    <div class="form-group">
                        <label>Kratki opis</label>
                        <input type="text" placeholder="Kratki opis" class="form-control" name="KratkiOpis"required>
                        <div class="invalid-feedback">Unesite kapacitet!</div>
                    </div>
                    <div class="form-group">
                        <label>Cena</label>
                        <input type="text" placeholder="Cena" class="form-control" name="Cena" required>
                        <div class="invalid-feedback">Unesite cenu!</div>
                    </div>
                    <div class="form-group">
                        <label>Cena u poenima</label>
                        <input type="text" placeholder="Cena u poenima" class="form-control" name="CenaUPoenima" required>
                        <div class="invalid-feedback">Unesite cenu sobe u poenima!</div>
                    </div>
                    <div class="form-group">
                        <label>Kapacitet</label>
                        <input type="text" placeholder="Kapacitet" class="form-control" name="Kapacitet" required>
                        <div class="invalid-feedback">Unesite kapacitet!</div>
                    </div>
                    <div class="form-group">
                        <label>Poeni</label>
                        <input type="text" placeholder="Poeni" class="form-control" name="Poeni" required>
                        <div class="invalid-feedback">Unesite broj poena koje soba donosi!</div>
                    </div>
                    <div class="form-group">
                        <label>Slika</label>
                        <input type="file" class="form-control-file" style="color: whitesmoke" id="profile-img" name="file" required>
                        <img src="" id="profile-img-tag" width="286px" />
                        <div class="invalid-feedback">Odaberite sliku!</div>
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btn btn-success form-control" value="Kreiraj sobu" style="margin-top: 1.5%">
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
    </body>
</html>

