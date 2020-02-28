<%-- 
    Document   : myLibrary
    Created on : Feb 22, 2020, 6:50:58 PM
    Author     : golu
--%>

<%@page import="storyteller.model.UserModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashSet"%>
<%@page import="storyteller.pojo.Story"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <head>
        <title>Library</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/library.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
    </head>
    <body>
        <ul class="navv">
            <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
            <p class="navtitle">The Storyteller</p>
            <li><a href="logout.jsp">Logout</a></li>
            <li><a href="profile.jsp" >My Profile</a></li>
            <li><a href="myLibrary.jsp" class="active">My Library</a></li>
            <li><a href="writeNewStory.jsp">Write A Story</a></li>
            
            <li><a href="index.jsp">Home</a></li>
        </ul>
        
    <div class="my_container">
    
         <div class="feeds_div">
            <%
                String user_id = (String)session.getAttribute("user_mail");
                ArrayList<Story> sList = StoryModel.getAllSavedStories(user_id);
                HashSet<String> likedSid = StoryModel.getAllLikes(user_id);
                HashSet<String> savedSid = StoryModel.getAllSaves(user_id);
                
                int n = sList.size();
                if(n==0){
            %>
               <p style="margin-top:50px;margin-left:20%;font-family:'Gabriola';font-size:28px;color:#FB7C39;padding:0px;" ><b>No Stories in your Library right now!!</b></p>
               
            <%
                }else{
            %>
            <p style="margin-top:50px;font-family:'Gabriola';font-size:28px;color:#FB7C39;padding:0px;" ><b>Stories in your Library:</b></p>
    
            <%
                for(int i=0;i<n;i++){
                    Story sobj = sList.get(i);
            %>
            <div class="row story_card">
                <div class="col-sm-3">
                    <img class="img-thumbnail cover_pic" src="getImage.jsp?id=<%=sobj.getSid()%>" alt="No image" style="border: 0px solid red;">
                </div>

                <div class="col-sm-9">
                    <h4 style="margin:0px;"><%=sobj.getTitle()%></h4>
                    <div class="row">
                        <div class="col-sm-3">
                            Author:<a href="publicProfile.jsp?user_id=<%=sobj.getAuthor()%>"> <%=UserModel.getFullName(sobj.getAuthor())%></a>
                        </div>
                        <div class="col-sm-3">
                            Theme: <%=sobj.getTheme_name()%>
                        </div>
                        <div class="col-sm-3">
                            No of Parts: <%=StoryModel.getNumOfParts(sobj.getSid()) %>
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
                            <%
                                String sid = sobj.getSid();
                                if(savedSid.contains(sid)){
                            %>
                            <!--Save button-->
                            <button  class="icon_btn" id="<%=sobj.getSid()%>Add" style="background-color:#5eb7f7;color:white;border-radius:5px;" onclick="loadLibrary('<%= sobj.getSid()%>')" >
                                <img class="t_img" src="Images\bookmark.png" width="25" height="25" id="<%=sobj.getSid()%>btn_saved_img" style="animation-duration:1s">
                                <span id="<%=sobj.getSid()%>AddSpan"><%=sobj.getNumSaves() %></span>
                            </button>
                            <%
                                }
                                else{
                            %>
                            <button  class="icon_btn" id="<%=sobj.getSid()%>Add" style="background-color:white;color:black;border-radius:5px;" onclick="loadLibrary('<%= sobj.getSid()%>')" >
                                <img class="t_img" src="Images\bookmark.png" width="25" height="25" id="<%=sobj.getSid()%>btn_saved_img" style="animation-duration:1s">
                                <span id="<%=sobj.getSid()%>AddSpan"><%=sobj.getNumSaves() %></span>
                            </button>
                            <%
                                }
                                if(likedSid.contains(sid)){
                            %>
                            <!--Like button-->
                            <button class="icon_btn"  id="<%=sobj.getSid()%>Like"  style="background-color:#ba9ce6;border-radius:5px;color:white" onclick="loadRating('<%= sobj.getSid()%>')">
                                <img  src="Images\thumb2.png" width="25" height="25" id="<%=sobj.getSid()%>btn_img" style="animation-duration:1s">
                                <span id="<%=sobj.getSid()%>LikeSpan"><%=sobj.getRating() %></span>
                            </button>
                            <%
                            }
                            else{
                            %>
                            <button class="icon_btn"  id="<%=sobj.getSid()%>Like"  style="border-radius:5px;color:black" onclick="loadRating('<%= sobj.getSid()%>')">
                                <img  src="Images\thumb2.png" width="25" height="25" id="<%=sobj.getSid()%>btn_img" style="animation-duration:1s">
                                <span id="<%=sobj.getSid()%>LikeSpan"><%=sobj.getRating() %></span>
                            </button>
                            <%
                            }
                            %>
                            <button class="action_btn" ><a class="r_link" href="startReading.jsp?SID=<%=sobj.getSid()%>&stitle=<%=sobj.getTitle()%>" style="color:white;" > Start Reading </a></button>
                            
                        </div>
                    </div>
                </div>
            </div>
            <%
            }
            }
            %> 
      
    </div>
</div>
<script>  
    function loadRating(sid) {
  var xhttp = new XMLHttpRequest();
  var url = "ratingUpdate.jsp?SID="+sid;
  
  var id = sid.concat("Like");
  var like_btn = document.getElementById(id);
  var btn_color = like_btn.style.backgroundColor;
  
  var btn_img = document.getElementById(sid+"btn_img");
  
  btn_img.style.animationName='btn_anim';
  setTimeout(function(){ btn_img.style.animationName="none"; }, 1200);
//  console.log(btn_img.style.animationName);
  if(btn_color=='rgb(186, 156, 230)'){
        console.log("here");
        like_btn.style.backgroundColor = 'white';
        like_btn.style.color='black';
        url = url + "&call_type=unLike";
    }else{
        like_btn.style.backgroundColor = 'rgb(186, 156, 230)';
        like_btn.style.color='white';
        url = url + "&call_type=Like";
    }
  
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById(sid.concat("LikeSpan")).innerHTML = this.responseText;
    }
  };
  xhttp.open("GET",url , true);
  xhttp.send();
}

function loadLibrary(sid){
    var xhttp = new XMLHttpRequest();
    var url = "libraryUpdate.jsp?SID="+sid;
    
    var id = sid.concat("Add");
    var save_btn = document.getElementById(id);
    var btn_color = save_btn.style.backgroundColor;
    
    var btn_img = document.getElementById(sid+"btn_saved_img");
    btn_img.style.animationName='btn_anim';
    setTimeout(function(){ btn_img.style.animationName="none"; }, 1200);
    
    if(btn_color == 'rgb(94, 183, 247)'){
        save_btn.style.backgroundColor = 'white';
        save_btn.style.color='black';
        url = url + "&call_type=unSave";
    }else{
        save_btn.style.backgroundColor = 'rgb(94, 183, 247)';
        save_btn.style.color='white';
        url = url + "&call_type=Save";
    }
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById(sid.concat("AddSpan")).innerHTML = this.responseText;
    }
  };
    xhttp.open("GET",url , true);
    xhttp.send();    
}
</script>
    </body>
</html>
