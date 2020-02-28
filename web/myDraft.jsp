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
    <title>Draft</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="CSS_Styles/newProfile.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <%
         String user_id = (String) session.getAttribute("user_mail");
    %>
    <!-----------------------Navigation Bar------------------------------>
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp" class="active">My Profile</a></li>
        <li><a href="myLibrary.jsp" >My Library</a></li>
        <li><a href="writeNewStory.jsp">Write A Story</a></li>
        
        <li><a href="index.jsp">Home</a></li>
    </ul>
<div class="container-fluid">
    <div class="row profile_head">
        <div class="col-sm-12">    
            <div class="row intro">
                <div class="col-sm-2">
                    <div style="width:150px;height:150px;border:1px solid lightgray;border-radius:50%;overflow:hidden;float:right;background-color: white">
                        <center>

                            <img src="getProfileImage.jsp?user_id=<%=session.getAttribute("user_mail")%>" class="" id="myimg">

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
                    %>
                    <p class="pro_name"><%= user.getFull_name()%></p>
                    <p class="pro_bio"><%= user.getBio() %></p>
                    <a href="editProfile.jsp" class="intro_col_a">Edit Profile</a>
                </div>
                <div class="col-sm-4 into_col">
                    <%
                        HashMap< String,String> followers = UserModel.getAllFollowers(user_id);
                        HashMap< String,String> following = UserModel.getAllFollowing(user_id);
                    %>
                     <span class="intro_col_a" onclick="document.getElementById('myModalId').style.display='block';">Followers: <%= followers.size()%></span>
                     <span class="intro_col_a" onclick="document.getElementById('following_id').style.display='block';">Following: <%= following.size()%></span>
                     <a href="Drafts.html" class="intro_col_a">My Drafts</a>
                </div>
            </div>          
        </div>
    </div>
</div>

<div class="my_container">
    <p style="margin-top:50px;margin-left:20%;font-family:'Gabriola';font-size:28px;color:#FB7C39;padding:0px;" ><b>Your Drafted Stories:</b></p>
    
         <div class="feeds_div">
            <%
                
                ArrayList<Story> sList = StoryModel.getAllDraftStories(user_id);
                
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
                            Author:<a href="publicProfile.jsp?user_id=<%=sobj.getAuthor()%>"> <%=UserModel.getFullName(sobj.getAuthor())%></a>
                        </div>
                        <div class="col-sm-3">
                            Theme: <%=sobj.getTheme_name()%>
                        </div>
                        <div class="col-sm-3">
                            No of Parts: <%=sobj.getNumParts() %>
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
                            <button class="action_btn" ><a class="r_link" href="publishDraft.jsp?SID=<%=sobj.getSid()%>" style="color:white;" > Publish </a></button>
                            <button class="action_btn" ><a class="r_link" href="editStory.jsp?SID=<%=sobj.getSid()%>" style="color:white;" > Continue Writing </a></button>
                            <button class="action_btn" ><a class="r_link" href="deleteStory.jsp?SID=<%=sobj.getSid()%>" style="color:white;" >Delete Draft</a></button>
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
    </script>
</div>


    </body>
</html>