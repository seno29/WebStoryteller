<%-- 
    Document   : editStory
    Created on : Feb 21, 2020, 4:34:11 PM
    Author     : golu
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Story</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="CSS_Styles/editStory.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <ul class="navv">
            <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
            <p class="navtitle">The Storyteller</p>
            <li><a href="logout.jsp">Logout</a></li>
            <li><a href="profile.jsp" class="active">My Profile</a></li>
            <li><a href="myLibrary.jsp" >My Library</a></li>
            <li><a href="writeNewStory.jsp">Write A Story</a></li>
            
            <li><a href="index.jsp">Home</a></li>
        </ul>
        <%
            String sid = request.getParameter("SID");
            TreeMap<Integer,String> parts = StoryModel.getAllPartsBySid(sid);
        %>
        <div class="container main">
            <div class="row ">
                <table>
                    <tr colspan="3">
                        <td><a href="editDesc.jsp?SID=<%=sid%>">Edit Description</a></td>
                    </tr>
                    <tr colspan="3">
                        <td><a href="AddPart.jsp?SID=<%=sid%>">+Add Another Part</a></td>
                    </tr>
                    <%
                        for(Map.Entry<Integer,String> e:parts.entrySet()){
                            int pno = e.getKey();
                            String ptitle = e.getValue();
                            String status = StoryModel.getPartStatus(sid,pno);
                    %>
                    <tr>
                        <td class="ptitle">Part <%=pno%>: <%=ptitle%> </td>
                        <td class="ptitle" style="color:grey"> <%=status%>ed </td>
                        <td class="popt" style="width:200px"><a href="editPart.jsp?SID=<%=sid%>&PNO=<%=pno%>" style="width:200px"> Edit </a></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
    </body>
</html>
