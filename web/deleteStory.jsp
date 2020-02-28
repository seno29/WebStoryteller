<%-- 
    Document   : deleteStory
    Created on : Feb 21, 2020, 9:38:20 PM
    Author     : golu
--%>

<%@page import="storyteller.model.StoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String sid = request.getParameter("SID");
    boolean status = StoryModel.deleteStory(sid);
    if(status){
        response.sendRedirect("profile.jsp");
    }else{
        out.print("unable to delete story");
    }
%>
