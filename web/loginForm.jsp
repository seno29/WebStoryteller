<%-- 
    Document   : loginForm
    Created on : Dec 11, 2019, 4:58:26 PM
    Author     : golu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Login to get started</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/loginCSS.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-6 im">
                    <img  src="Images/pic1.png" width="300" height="300" style="margin-top:100px;"> 
                    <p class="storyTitle">The Storyteller</p>                   
                </div>
                <div class="col-sm-5 loginForm">
                    <h2>It's good to see you again!!!</h2>
                    <form method="post" action="LoginServlet">
                        <span >
                            <input type="radio" name="type" value="Admin" required> <label>Admin</label>
                        </span>
                        <span style="margin-left:120px;">
                            <input type="radio" name="type" value="User" required> <label>User</label><br>
                        </span>
                        <label>Email:</label><br>
                        <input type="email" name="email" id="email" required><br>
                        <label>Password:</label><br>
                        <input type="password" name="pass" id="pass" onkeyup="myfun()" required><br>
                        <p id="err" style="color:red;font-weight:bold;"></p>
                        <button type="submit" class="submitBtn">Login</button>   
                    </form>                    
                    <h4 class="registerLink">Don't have an account? <a href="registerForm.jsp"><u>Register</u></a></h4>                
                </div>
            </div>
        </div>
        
        <script>
            var pass = document.getElementById("pass");
            function myfun(){
                if(pass.value.length<8){
                   document.getElementById("err").innerHTML = "<u>Password must contain 8 characters!!</u>"; 
                }else{
                    document.getElementById("err").innerHTML = "";
                }
            }
        </script>    
    </body> 
    <%
        String status=request.getParameter("isvalid");
        if(status!=null && status.equals("false")){
    %>
    <script>
        alert("Invalid credentials. Please try again..");
    </script>
    <%
        }
    %>
</html>
