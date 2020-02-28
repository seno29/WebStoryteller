
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
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
        <li><a href="profile.jsp" class="active">My Profile</a></li>
        <li><a href="myLibrary.jsp">My Library</a></li>
        <li><a href="WriteStory.html">Write A Story</a></li>
        <li><a href="">Search</a></li>
        <li><a href="index.jsp">Home</a></li>
    </ul>
        <div class="container-fluid">
        <p class="title">Edit Profile</p>
        
        <div class="row">
            <div class="col-sm-3">
                
            </div>
            <div class="col-sm-6">
                <form action="" method="post" id="frm">
                    <label><b>Old Password: </b></label>
                    <input type="password" name="old_pass"  id="old_pass" required><br><br>
                    <label><b>New Password: </b></label>
                    <input type="password" name="new_pass" id="new_pass" onkeyup="myfun()" required><br><br>
                    <label><b>Confirm Password: </b></label>
                    <input type="password" name="con_pass" id="con_pass" required><br><br>
                    
                    <button onclick="submitData()">Save Changes</button>
                    
                </form>
                
            </div> 
            <div class="col-sm-3"></div>  
        </div>
        <p id="demo"></p>
    </div>
    <script>
        function submitData(){
            var newPass = document.getElementById("new_pass").value;
            var conPass = document.getElementById("con_pass").value;
            var oldPass = document.getElementById("old_pass").value;
            var frm = document.getElementById("frm");
            if(newPass!=conPass){
                alert("Confirm Password does not match with new password!! Try Again");
            }else if(newPass.length<8 || conPass.length<8 || oldPass<8){
                alert("length of password should be at least 8 characters");
            }else{
                frm.action="ChangePasswordServlet";
            }
            
        }
    </script>
    
    <%
        String pchanged =request.getParameter("pass_changed");
        if(pchanged!=null && pchanged.equals("true")){                     
    %>
        <script>
            alert("password changed successfully");
        </script>
    <%
        response.sendRedirect("profile.jsp");
        }else if(pchanged!=null && pchanged.equals("false")){
    %>
    <script>
        alert("old password did not match");
    </script>
    <%
        }
    %>
    </body>
</html>
