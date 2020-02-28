<%-- 
    Document   : registerForm
    Created on : Dec 12, 2019, 4:22:31 PM
    Author     : golu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Register</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/loginCSS.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-6 im">
                    <img src="Images/pic1.png" width="300" height="300" style="margin-top:100px;"> 
                    <p class="storyTitle">The Storyteller</p>                   
                </div>
                <div class="col-sm-5 registerForm">
                    <h2>Welcome to Storyteller!!!</h2>
                    <form method="post" action="" id="regForm">
                        <label>Full Name:</label><br>
                        <input type="text" name="name" required><br>
                        
                        <label>Email:</label><br>
                        <input type="email" name="email" required><br>
                        
                        <label>Password:</label><br>
                        <input type="password" name="pass" id="pass" onkeyup="checkPassLength()" required><br>
                        <p id="err1"></p>
                        
                        <label>Confirm Password:</label><br>
                        <input type="password" name="con_pass" id="con_pass" onkeyup="confirmPass()" required><br>
                        <p id="err"></p>
                        
                        <button type="submit" class="submitBtn" onclick="callServlet()">Register</button>   
                    </form>
                    <h4 class="loginLink">Already have an account? <a href="loginForm.jsp"><u>Login</u></a></h4>
                </div>
            </div>
        </div>
    </body>
    <%
        String status=request.getParameter("is_pass_match");
        if(status!=null && status.equals("false")){
    %>
    <script>
        alert("Password and confirm password does not match. Please try again..");
    </script>
    <%
        }
    %>
    <%
        String reg=request.getParameter("is_register");
        if(reg!=null && reg.equals("false")){
    %>
    <script>
        alert("Some Error Occured in database. Please try again later..");
    </script>
    <%
        }
    %>
    <script>
        function confirmPass(){
            var pass = document.getElementById("pass");
            var con_pass = document.getElementById("con_pass");
            console.log(pass==con_pass);
            if(pass.value != con_pass.value){
                document.getElementById("err").innerHTML = "password do not match!";
                
            }else{
                document.getElementById("err").innerHTML = "hurray! matched";
            }
        }
        function checkPassLength(){
            var pass = document.getElementById("pass");
            
            if(pass.value.length<8){
                document.getElementById("err1").innerHTML = "password should contain at least 8 characters";
            }else{
                document.getElementById("err1").innerHTML = "";
            }
        }
        function callServlet(){
            document.getElementById("regForm").action="RegisterServlet";
        }
    </script>
</html>