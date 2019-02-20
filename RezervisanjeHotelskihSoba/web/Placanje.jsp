
<%@page import="Models.Soba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plaćanje</title>
    </head>
    <style>
        label{
            font-weight: bold;
            color: whitesmoke;
        }
    </style>
    <body>
        <jsp:include page="navbar.jsp" />  
        <br><br><br>
        <center><h4 style="color: white; font-weight: bold; margin-top: 15px">PLAĆANJE</h4></center>
        
        <form action="Naplacivanje" method="post" class="main-form needs-validation"  novalidate style="width: 450px; margin: 2% auto; background: rgba(0, 0, 0, 0.5); border-radius: 7px; padding:15px;">
            <input type="hidden" name="BrojPoena" value="<%=request.getAttribute("BrojPoena")%>">
                    <div class="col">
                        <div class="form-group">
                            <label>Kreditna kartica</label>
                            <select name="VrstaKartice" class="form-control">
                                <option value="Visa"> Visa </option>
                                <option value="Maestro"> Maestro </option>    
                                <option value="MasterCard"> MasterCard </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Broj kreditne kartice</label>
                            <input class="form-control"  id="phone" type="text" name="BrojKartice" placeholder="XXXX-XXXX-XXXX-XXXX" required>
                            <div class="invalid-feedback">Unesite broj kreditne kartice!</div>
                        </div>
                    </div>    
                <div class="row" style="margin: 2% auto;">
                    <div class="col">
                        <div class="form-group">
                            <label>Mesec isteka</label>
                            <select name="DatumIstekaMesec" class="form-control">
                                <%
                                    for(int i = 1; i<=12; i++) {
                                        {%>
                                        <option value="<%=i%>"> <%=i%> </option>
                                        <%}
                                    }
                                %>
                                <input type="hidden" value="<%=request.getAttribute("CenaUPoenima")%>" name="CenaUPoenima">
                            </select>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label>Godian isteka</label>
                            <select name="DatumIstekaGodina" class="form-control">
                                <%
                                    for(int i = 2019; i<=2040; i++) {
                                        {%>
                                            <option value="<%=i%>"> <%=i%> </option>
                                        <%}
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                </div>
                <hr style="border-top: dashed 2px; height:1px; margin: 0 3%; color: whitesmoke"/>
                <center>
                     <% if(request.getAttribute("Racun")!=null){ 
                         {%>
                             <h4 style="color: white; font-weight: bold; margin-top: 15px">Račun: <%=request.getAttribute("Racun")%> EUR</h4> 
                          <%}
                        }
                     %>
                     <input  type="submit" name="NaplacivanjeNovcem" value="Potvrdi plaćanje" class="btn btn-success" style="margin-top: 2%; margin-bottom: 5%"> 
                </center>
                <hr style="border-top: dashed 2px; height:1px; margin: 0 3%; color: whitesmoke;"/>
                    <% 
                    if(request.getAttribute("CenaUPoenima")!=null)
                            if((Integer)request.getSession().getAttribute("BrojPoenaKorisnika") >= (Integer)request.getAttribute("CenaUPoenima")){ 
                            {%>
                            <center>
                               <h5 style="color: whitesmoke; font-weight: bold; margin: 3% 3%;">Ili platite Starling poenima</h5>
                               <h4 style="color: whitesmoke; font-weight: bold; margin: 3% 3%;">Trenutno imate: <u><%=request.getSession().getAttribute("BrojPoenaKorisnika")%></u> poena</h4>

                               <input type="submit" style="color: whitesmoke; font-weight: bold; background-color: orange" value="Plati sa <%=request.getAttribute("CenaUPoenima")%> poena" class="btn btn-warning">
                            </center>
                            <%}
                    }
                    else { 
                        {%> 
                            <h5 style="color: white; font-weight: bold; margin: 3% 3%;">Plaćanje Starling poenima</h5>
                            <h5 style="color: white; font-weight: bold; margin: 3% 3%;">Potrebno je <%=request.getAttribute("CenaUPoenima")%> poena.</h5>
                            <h4 style="color: white; font-weight: bold; margin: 3% 3%;">Trenutno imate: <u><%=request.getSession().getAttribute("BrojPoenaKorisnika")%></u> poena</h4>
                            <%}
                        }
                    %>
                </div>
            </div>  
        </form> 
           <%  if(request.getAttribute("poruka")!=null){
                if (request.getAttribute("poruka").equals("True")){ 
                    {%> 
           <script type="text/javascript">
                         swal("Dobar  posao", "Rezervacija uspela", "success")
                         .then(function() {
                             window.location = "index.jsp";
                         });
                     <%}
                } 
                    else if(request.getAttribute("poruka").equals("False")){
                         {%> 
                             <script type="text/javascript">
                         swal("Dobar  posao", "Rezervacija uspešna", "success")
                         .then(function() {
                             window.location = "index.jsp";
                         });
                     <%}
                    }
                }
            %>
           </script>
        </form>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
        <script>
            $(document).ready(function(){
            $('#phone').mask('9999-9999-9999-9999');
          });
        </script>
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
