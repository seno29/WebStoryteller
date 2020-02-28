<%-- 
    Document   : logout
    Created on : Feb 20, 2020, 10:50:39 PM
    Author     : golu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("user_mail");
    session.invalidate();
    response.sendRedirect("loginForm.jsp");
%>