<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storyteller.pojo.Story"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="storyteller.pojo.User"%>
<%@page import="storyteller.model.UserModel"%>
<!DOCTYPE html>
<html>

<head>
    
    <title>Profile</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="CSS_Styles/newProfile.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script>
    function fun1(fid,tagid){
        console.log("fun1 called "+fid);
        var im = document.getElementById(tagid);
        width = im.naturalWidth || im.width;
        height = im.naturalHeight || im.height;
        if(height>width){
            im.style.height="50px";
        }
        else{
            im.style.width="50px";
            var xper = (50*100)/width;
            var m = (50 - (height*xper)/100)/2;
            console.log(m);
            im.style.marginTop=m+"px";
        }
        console.log(width);
        console.log(height);
    }
    
    function loadFollower(fid){
        fun1(fid,fid+"Follower");
    }
    function loadFollowing(fid){
        fun1(fid,fid+"Following");
    }
    function follow(user){
        var ftag = document.getElementById("follow");
        var xhttp = new XMLHttpRequest();
        var url="follow.jsp?call_type=";
        
        if(ftag.style.backgroundColor=='rgb(251, 124, 57)'){
            ftag.style.backgroundColor='white';
            ftag.style.border = '1px solid #FB7C39';
            ftag.style.color = 'rgb(251, 125, 57)';
//            ftag.innerHTML = 'Unfollow'
            url = url+"follow"+"&f_id="+user;
            console.log(url);
        }else{
            ftag.style.backgroundColor='rgb(251, 124, 57)';
            ftag.style.color = 'white';
//            ftag.innerHTML = 'Follow'
            url = url+"unfollow"+"&f_id="+user;
            console.log(url);
        }
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
              ftag.innerHTML = this.responseText;
            }
          };
        xhttp.open("GET",url , true);
        xhttp.send();
        
    }
    </script>
</head>

<body>
    <%
         String user_id = request.getParameter("user_id");
         String curr_user = (String) session.getAttribute("user_mail");
    %>
    <!-----------------------Navigation Bar------------------------------>
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp">My Profile</a></li>
        <li><a href="myLibrary.jsp" >My Library</a></li>
        <li><a href="writeNewStory.jsp">Write A Story</a></li>
        <li><a href="index.jsp">Home</a></li>
        <div class="" style="width:500px;margin-left:350px;margin-top:5px;">
            <form action="searchResult.jsp" style="margin-bottom:0px;">
                <input type="text" name="s_qry" style="height:30px;width:350px;padding:0px;border:1px solid lightgrey;border-radius:5px;">
                <input type="submit" style="width:100px;margin-left:0px;border-radius:5px;" value="Search">
            </form>
        </div>
    </ul>
<div class="container-fluid">
    <div class="row profile_head">
        <div class="col-sm-12">    
            <div class="row intro">
                <div class="col-sm-2">
                    <div style="width:150px;height:150px;border:1px solid lightgray;border-radius:50%;overflow:hidden;float:right;background-color: white">
                        <center>

                            <img src="getProfileImage.jsp?user_id=<%=user_id%>" class="" id="myimg">

                        </center>
                    </div>
                            <script>
                                var width,height;
                                var img = document.getElementById("myimg");
                                img.onload = function () {
                                    width = img.naturalWidth || img.width;
                                    height = img.naturalHeight || img.height;

                                    if(height>width){
                                        img.style.height="150px";
                                    }
                                    else{
                                        img.style.width="150px";
                                        var xper = (150*100)/width;
                                        var m = (150 - (height*xper)/100)/2;
                                        console.log(m);
                                        img.style.marginTop=m+"px";
                                    }
                                    console.log(width);
                                    console.log(height);
                                };
                            </script>
                </div>
                <div class="col-sm-6 into_col">
                    <%
                        User user = UserModel.getUserData(user_id);
                       
                        HashMap< String,String> followers = UserModel.getAllFollowers(user_id);
                        HashMap< String,String> following = UserModel.getAllFollowing(user_id);
                    %>
                  
                    <p class="pro_name"><%= user.getFull_name()%></p>
                    <p class="pro_bio"><%= user.getBio() %></p>
                    <%
                        if(!followers.containsKey(curr_user)){
                    %>
                        <button class="icon_btn" id="follow" style="background-color: #FB7C39;color:white;width:150px" onclick="follow('<%=user_id%>')">Follow</button>
                    <%
                        }else{
                    %>
                    <button class="icon_btn" id="follow" style="background-color: white;border:1px solid #FB7C39;color:#FB7C39;width:150px" onclick="follow('<%=user_id%>')">UnFollow</button>
                    <%
                        }
                    %>
                </div>
                <div class="col-sm-4 into_col">
                    
                     <span class="intro_col_a" onclick="document.getElementById('myModalId').style.display='block';">Followers: <%= followers.size()%></span>
                     <span class="intro_col_a" onclick="document.getElementById('following_id').style.display='block';">Following: <%= following.size()%></span>
                </div>
            </div>          
        </div>
    </div>
</div>

<div class="my_container">
    <p style="margin-top:50px;margin-left:20%;font-family:'Gabriola';font-size:28px;color:#FB7C39;padding:0px;" ><b><%= user.getFull_name()%>'s Published Stories:</b></p>
    
         <div class="feeds_div">
            <%
                
                ArrayList<Story> sList = StoryModel.getAllStoriesByAuthor(user_id);
                HashSet<String> likedSid = StoryModel.getAllLikes(user_id);
                HashSet<String> savedSid = StoryModel.getAllSaves(user_id);
                
                int n = sList.size();
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
                            Author:<a href="publicProfile?user_id=<%=sobj.getAuthor()%>"> <%=UserModel.getFullName(sobj.getAuthor())%></a>
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
            %> 
      
    </div>
</div>

<div class="follower_modal" id="myModalId">
    
    <div class="modal_content animate" >
        <span class="close" onclick="document.getElementById('myModalId').style.display='none';">&times</span>
        <center><h4>Followers</h4></center>
        
        <ul>
            <%
                for(Map.Entry< String,String> e : followers.entrySet()){
                    String f_id = e.getKey();
                    String f_name = e.getValue();
            %>
            <li>
                <div class="row">
                    <div class="col-sm-1">    
                        <div style="width:50px;height:50px;border:1px solid lightgray;border-radius:50%;overflow:hidden;background-color: white;">
                            <center>
                                <img src="getProfileImage.jsp?user_id=<%=f_id%>" class="" id="<%=f_id%>Follower" onload="loadFollower('<%=f_id%>')">
                            </center>
                        </div>
                    </div>
                    <div class="col-sm-4" style="margin-top:10px;"><%=f_name %></div>
                    <div class="col-sm-6"></div>
                </div>
            </li>
            <%
                }
            %>
        </ul>   
    </div>
</div>
<div class="follower_modal" id="following_id">
    
    <div class="modal_content animate" >
        <span class="close" onclick="document.getElementById('following_id').style.display='none';">&times</span>
        <center><h4>Following</h4></center>
        
        <ul>
            <%
                for(Map.Entry< String,String> e : following.entrySet()){
                    String f_id = e.getKey();
                    String f_name = e.getValue();
            %>
            <li>
                <div class="row">
                    <div class="col-sm-1">    
                        <div style="width:50px;height:50px;border:1px solid lightgray;border-radius:50%;overflow:hidden;background-color: white;">
                            <center>
                                <img src="getProfileImage.jsp?user_id=<%=f_id%>"  id="<%=f_id%>Following" onload="loadFollowing('<%=f_id%>')">
                            </center>
                        </div>
                    </div>
                    <div class="col-sm-4" style="margin-top:10px;"><%=f_name %></div>
                    <div class="col-sm-6"></div>
                </div>
            </li>
            <%
                }
            %>
        </ul>   
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