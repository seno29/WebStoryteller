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
        <li><a href="dashboard.jsp" class="active">DashBoard</a></li>
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
                    if(StoryModel.isValidPendingPartNo(sid,pno-1)){
                %>
                <a href="reviewPartContent.jsp?SID=<%=sid%>&pno=<%=(pno-1)%>&stitle=<%=stitle%>" class="pager_btn">&#8249; Prev</a>
                <%
                    }
                %>
                <%
                    if(StoryModel.isValidPendingPartNo(sid,pno+1)){
                %>
                <a href="reviewPartContent.jsp?SID=<%=sid%>&pno=<%=(pno+1)%>&stitle=<%=stitle%>" class="pager_btn" style="float:right">Next &#8250;</a>
                <%
                    }
                %>
                <br>
                <hr style="margin:30px 0px 30px 0px">
            </div>
        </div>    
    </div>
</body>
</html>