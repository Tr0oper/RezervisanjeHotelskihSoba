

<%@page import="RepoPattern.HotelRepo"%>
<% new HotelRepo().fotografije(request, response, request.getParameter("hotelID")); %>
