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
        <link rel="stylesheet" href="CSS_Styles/read_review.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    </head>
<body>
    <%
        String sid = request.getParameter("SID");
        String stitle = request.getParameter("stitle");
        TreeMap<Integer,String> ptitle = StoryModel.getAllPendingPartsTitle(sid);
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
                <p class="s_title"><%=stitle%></p>
                
                <table>
                    <%
                        for(Map.Entry<Integer,String> e:ptitle.entrySet()){
                            int pno = e.getKey();
                            String title=e.getValue();
                            String status = StoryModel.getPartStatus(sid, pno);
                    %>
                    <tr>
                        <td class="part_num">Part <%=pno%></td>
                        <td class="ptitle"><a href="reviewPartContent.jsp?SID=<%=sid%>&pno=<%=pno%>&stitle=<%=stitle%>"><%=title%></a></td>
                        <td class="status"><%=status%></td>                       
                    </tr>
                    <%
                    }
                    %>
                    
                </table>    
            </div>
        </div>    
        
    </div>

</body>
</html>