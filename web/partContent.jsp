<%@page import="storyteller.model.UserModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storyteller.pojo.Comment"%>
<%@page import="storyteller.pojo.Parts"%>
<%@page import="storyteller.model.StoryModel"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Part Content</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/part_content.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
<body style="background-color:#FEEFED">
    <%
        String stitle = request.getParameter("stitle");
        int pno = Integer.parseInt(request.getParameter("pno"));
        String sid=request.getParameter("SID");
        Parts p = StoryModel.getPartContent(sid, pno);
    %>
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp" >My Profile</a></li>
        <li><a href="myLibrary.jsp" >My Library</a></li>
        <li><a href="writeNewStory.jsp" >Write A Story</a></li>
      
        <li><a href="index.jsp" >Home</a></li>
    </ul>
    <div class="container">
        <div class="row part_div">
            <div class="col-sm-12">
                <center>
                    <p class="s_title"><%=stitle%></p>
                    <p class="part_title">Part <%=pno%>: <%=p.getPart_title()%></p>
                </center>
                <img class="img-thumbnail" src="getPartImage.jsp?SID=<%=sid%>&PNO=<%=pno%>" alt="No image available" height="350" width="250" style="float:right;padding:10px">
                <p class="part_content">
                <%=p.getPart_content()%>
                </p>
                <%
                    if(StoryModel.isValidPartNo(sid,pno-1)){
                %>
                <a href="partContent.jsp?SID=<%=sid%>&pno=<%=(pno-1)%>&stitle=<%=stitle%>" class="pager_btn">&#8249; Prev</a>
                <%
                    }
                %>
                <%
                    if(StoryModel.isValidPartNo(sid,pno+1)){
                %>
                <a href="partContent.jsp?SID=<%=sid%>&pno=<%=(pno+1)%>&stitle=<%=stitle%>" class="pager_btn" style="float:right">Next &#8250;</a>
                <%
                    }
                %>
                <br>
                <hr style="margin:30px 0px 30px 0px">
                <div class="row comments">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-8">
                        <div class="row">
                            <div class="col-sm-12">
                                <h4 style="font-family:'Gabriola' ;font-size:28px; font-weight: bold;">Comments</h4>
                                <form action="addComment.jsp">
                                    <input type="hidden" name="sid" value="<%=sid%>">
                                    <input type="hidden" name="pno" value="<%=pno%>">
                                    <input type="hidden" name="stitle" value="<%=stitle%>">
                                    <textarea rows="5" cols="50" class="comment_area" name="content"></textarea>
                                    <button type="submit" value="comment">Comment</button>
                                </form>    
                            </div>
                        </div>
                        
                        <%
                            ArrayList<Comment> comList = StoryModel.getAllComments(sid, pno);
                            
                            for(Comment c:comList){
                        %>
                        <div class="row disp_cmt">
                            <div class="col-sm-1">
                                <div style="width:50px;height:50px;border:1px solid lightgray;border-radius:50%;overflow:hidden;background-color: white;">
                                    <center>
                                        <img src="getProfileImage.jsp?user_id=<%=c.getUser_id()%>"  id="<%=c.getUser_id()+c.getDate_posted()%>" onload="fitImg('<%=c.getUser_id()+c.getDate_posted()%>')">
                                    </center>
                                </div>
                            </div>
                            
                            <div class="col-sm-11" >
                                <p class="cmt_name"><b><%= UserModel.getFullName(c.getUser_id()) %></b></p>
                                <p class="cmt_date"><%= c.getDate_posted() %></p>
                                <p class="cmt_content"><%= c.getContent() %></p>
                            </div>
                        </div>
                        <%
                        }
                        %>
<!--                        <div class="row disp_cmt">
                            <div class="col-sm-1">
                                <img src="Images/flat.png" width="40" height="40">
                            </div>
                            <div class="col-sm-11">
                                <p class="cmt_name"><b>Tulika Shrivastav</b></p>
                                <p class="cmt_date">03, Dec, 2019</p>
                                <p class="cmt_content">This is a classic horror story. I love it!!</p>
                            </div>
                        </div>-->
                    </div> 
                    <div class="col-sm-2">     
                    </div>   
                </div>

            </div>


        </div>    
        
    </div>
<script>
    function fitImg(user_id){
       
        var im = document.getElementById(user_id);
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
</script>
</body>
</html>