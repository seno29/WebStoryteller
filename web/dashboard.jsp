<%-- 
    Document   : dashboard
    Created on : Feb 26, 2020, 11:02:18 AM
    Author     : golu
--%>

<%@page import="storyteller.model.UserModel"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storyteller.pojo.Story"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="CSS_Styles/dashboard.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <%
         String admin_id = (String) session.getAttribute("admin_mail");
    %>
    <!-----------------------Navigation Bar------------------------------>
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp" >My Profile</a></li>
        <li><a href="dashboard.jsp" class="active">DashBoard</a></li>
    </ul>
    <div class="my_container">
    
         <div class="feeds_div">
            <%
//                String user_id = (String)session.getAttribute("user_mail");
                ArrayList<Story> sList = StoryModel.getPendingStories();
                int n=sList.size();
            %>
            <p style="margin-top:50px;font-family:'Gabriola';font-size:28px;color:#FB7C39;padding:0px;" ><b>Pending Stories:</b></p>
    
            <%
                for(int i=0;i<n;i++){
                    Story sobj = sList.get(i);
            %>
            <div class="row story_card" id="<%=sobj.getSid()%>">
                <div class="col-sm-3">
                    <img class="img-thumbnail cover_pic" src="getImage.jsp?id=<%=sobj.getSid()%>" alt="No image" style="border: 0px solid red;">
                </div>

                <div class="col-sm-9">
                    <h4 style="margin:0px;"><%=sobj.getTitle()%></h4>
                    <div class="row">
                        <div class="col-sm-3">
                            Author: <%=UserModel.getFullName(sobj.getAuthor())%>
                        </div>
                        <div class="col-sm-3">
                            Theme: <%=sobj.getTheme_name()%>
                        </div>
                        <div class="col-sm-3">
                            No of Parts: <%=StoryModel.getNumOfPendingParts(sobj.getSid()) %>
                        </div>
                        <div class="col-sm-3 story_date">
                            <%=sobj.getDate_modified()%>
                        </div>
                    </div>
                    <hr style="margin:10px 0px 10px 0px">

                    <div class="desc">
                        <%=sobj.getDescription()%>
                    </div>
                    <hr style="margin:10px 0px 10px 0px;">
                    <div class="row">
                        <div class="col-sm-12">
                            <button class="action_btn" onclick="publish('<%=sobj.getSid()%>')"> Publish </button>
                            <button class="action_btn" ><a class="r_link" href="raedReview.jsp?SID=<%=sobj.getSid()%>&stitle=<%=sobj.getTitle()%>" style="color:white;" > Read/Review </a></button>                         
                        </div>
                    </div>
                </div>
            </div>
            <%
            }
            %>      
    </div>
</div>
    <script>
        function publish(sid){
            var xhttp = new XMLHttpRequest();
            var url = "publishStory.jsp?SID="+sid;
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                      if(this.responseText=="yes"){
                          alert("published");
//                          var element = document.getElementById(sid);
//                          element.remove();
                      }
                    }
                };
            xhttp.open("GET",url , true);
            xhttp.send();
        }
    
    </script>
    </body>
</html>
