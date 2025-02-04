<%@page import="java.util.Map"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page import="java.util.TreeMap"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Reading</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS_Styles/start_reading.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
<body>
    <%
        String sid = request.getParameter("SID");
        String stitle = request.getParameter("stitle");
        TreeMap<Integer,String> ptitle = StoryModel.getAllPartsTitle(sid);
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
                <p class="s_title"><%=stitle%></p>
                <%
                    for(Map.Entry<Integer,String> e:ptitle.entrySet()){
                        String partTitle = e.getValue();
                        int pno = e.getKey();
                        
                %>
                <p class="part_title"><b>Part <%=pno%>:</b> <a href="partContent.jsp?SID=<%=sid%>&pno=<%=pno%>&stitle=<%=stitle%>"><%=partTitle%></a></p>
                <%
                    }
                %>
<!--                <p class="part_title"><b>Part 2:</b> <a href="">Part 2 Title</a></p>
                <p class="part_title"><b>Part 3:</b> <a href="">Part 3 Title</a></p>-->
<!--                <div class="progress_bar">
                    <div class="inner_div">
                        
                    </div>
                </div>
                <span style="float:right;color:orangered;">Read progress: 20%</span>-->
            </div>
        </div>    
        
    </div>

</body>
</html>