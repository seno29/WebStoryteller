<%-- 
    Document   : editProfile
    Created on : Feb 18, 2020, 12:04:38 PM
    Author     : golu
--%>

<%@page import="storyteller.model.UserModel"%>
<%@page import="storyteller.pojo.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Profile</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/edit_prof.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>   
    <body>
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="Profile.html" class="active">My Profile</a></li>
        <li><a href="myLibrary.jsp">My Library</a></li>
        <li><a href="WriteStory.html">Write A Story</a></li>
        <li><a href="index.jsp">Home</a></li>
    </ul>
        <div class="container-fluid">
        <p class="title">Edit Profile</p>
        <%
            String user_id = (String) session.getAttribute("user_mail"); 
            User user = UserModel.getUserData(user_id);
        %>
        <div class="row">
            <div class="col-sm-3">
                
            </div>
            <div class="col-sm-6">
                <form action="EditProfileServlet" method="post" enctype="multipart/form-data">
                    <label><b>Name: </b></label>
                    <input type="text" name="full_name" value="<%= user.getFull_name() %>"><br><br>
                    <label><b>Email: </b></label>
                    <input type="email" name="email_id" value="<%= user_id%>"><br><br>
                    <label><b>Bio: </b></label>
                    <input type="text" name="bio" value="<%= user.getBio()%>"><br><br>
                    <label><b>Upload image:</b></label>
                    <input type="file" name="pro_img">
                    <br><br>
                    
                    <button type="submit">Save Changes</button>
                    
                </form>
                <button ><a href="changePassword.jsp" style="color:white" id="chng_pass">Change Password</a></button>
            </div> 
            <div class="col-sm-3"></div>  
        </div>
    </div>
        
    </body>
</html>
