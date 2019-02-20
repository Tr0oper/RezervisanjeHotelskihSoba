
<%@page import="RepoPattern.SobeRepo"%>
<% new SobeRepo().fotografije(request, response, request.getParameter("SobaId")); %>