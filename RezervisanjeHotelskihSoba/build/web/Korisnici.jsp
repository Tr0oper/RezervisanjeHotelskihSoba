
<%@page import="RepoPattern.KorisnikRepo"%>
<%@page import="Models.Korisnik"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="navbar.jsp" /> 
        <title>Korisnici</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    </head>
    <style>
        label{
            color: whitesmoke;
        }
        #Tabela_info{
            color: whitesmoke;
        }
        #Tabela tbody tr{
            background: rgba(0,0,0,0.5);
            color: whitesmoke;
        }
        #Tabela tbody tr:hover{
            background: rgba(0,0,0,0.7);
        }
         .table-hover thead tr{
            color: whitesmoke;
        }
        #Tabela label{
            color: whitesmoke;
            
        }
        .fa-trash-alt{
            color: red;
        }
        .fa-trash-alt:hover{
            color: #cc0000;
        }
    </style>
    <body>

        <%
            if (request.getSession().getAttribute("UlogovanaRola") != null) {
                if (!request.getSession().getAttribute("UlogovanaRola").equals("2")) {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
        
        <center><h4 style="color: whitesmoke; font-weight: bold; font-family: roboto; margin-top: 2%; padding-bottom: 2%">PREGLED SVIH KORISNIKA </h4></center>
        
        <div style="width: 96%; margin-left: 2%;">
            <table id="Tabela" class="table table-hover table-dark" style=" background: rgba(0,0,0,0.5); color:black;  font-family: Roboto;">
                <thead style="font-size: 13px;">
                        <tr>
                          <th scope="col" class="align-middle text-center">#</th>
                          <th scope="col" class="align-middle text-center">Ime</th>
                          <th scope="col" class="align-middle text-center">Prezime</th>
                          <th scope="col" class="align-middle text-center">Korisničko ime</th>
                          <th scope="col" class="align-middle text-center">E-mail</th>
                          <th scope="col" class="align-middle text-center">Telefon</th>
                          <th scope="col" class="align-middle text-center">Adresa</th>
                          <th scope="col" class="align-middle text-center">Država</th>
                          <th scope="col" class="align-middle text-center">Grad</th>
                          <th scope="col" class="align-middle text-center">Rola</th> 
                          <th scope="col" class="align-middle text-center">Poeni</th>                      
                          <th scope="col" class="align-middle text-center">Poštanski Broj</th>
                          <th scope="col" class="align-middle text-center">Opcije</th>
                        </tr>
                </thead>
                <tbody>
                <%
                    int  i = 1;
                    for(Korisnik kor: new KorisnikRepo().lista()){
                        String Rola = "";
                        if (kor.getRola().equals("1"))
                            Rola = "Korisnik";
                        else if(kor.getRola().equals("2"))
                            Rola = "Administrator";
                        else
                            Rola = "Menadžer hotela";
                        { %>
                            <tr>
                                <td class="align-middle text-center"><%= i++ %></td>
                                <td class="align-middle text-center"><%=kor.getIme() %></td>
                                <td class="align-middle text-center"><%=kor.getPrezime()%></td>
                                <td class="align-middle text-center"><%=kor.getKorisnickoIme()%></td>
                                <td class="align-middle text-center"><%=kor.getEmail()%></td>
                                <td class="align-middle text-center"><%=kor.getTelefon().replace("-", "") %></td>
                                <td class="align-middle text-center"><%=kor.getAdresa()%></td>
                                <td class="align-middle text-center"><%=kor.getDrzava()%></td>
                                <td class="align-middle text-center"><%=kor.getGrad()%></td>
                                <td class="align-middle text-center"><%=Rola%></td>
                                <td class="align-middle text-center"><%=kor.getPoeni()%></td>
                                <td class="align-middle text-center"><%=kor.getPostanskiBroj()%></td>
                                <td class="align-middle text-center"> 
                                    <a href="${pageContext.request.contextPath}/PromenaKorisnika.jsp?Korisnik_Id=<%= kor.getId()%>">
                                        <i class="fas fa-user-edit"></i>
                                    </a> &nbsp;
                                    <a href="${pageContext.request.contextPath}/Korisnici?Korisnik_Id=<%= kor.getId()%>">
                                        <i class="fa fa-trash-alt"></i>                                  
                                    </a>
                                </td>
                            </tr>
                    <%} } %>
                </tbody>
            </table>
        </div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#Tabela').DataTable();
        });
    </script>
    </body>
</html>
