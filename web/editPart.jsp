<%@page import="storyteller.pojo.Parts"%>
<%@page import="storyteller.model.StoryModel"%>
<!DOCTYPE html>
<html>

<head>
    <title>Add Part</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS_Styles/addPart.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <!-----------------------Navigation Bar------------------------------>
    <!-- <img class="bgrnd" src="Images/Colorful-Geometric-Backgrounds-PNG.png"> -->
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp" >My Profile</a></li>
        <li><a href="myLibrary.jsp" >My Library</a></li>
        <li><a href="writeNewStory.jsp" class="active">Write A Story</a></li>
        <li><a href="index.jsp">Home</a></li>
    </ul>
    <%
        String sid=request.getParameter("SID"); 
        int pno = Integer.parseInt(request.getParameter("PNO"));
        String status = StoryModel.getPartStatus(sid, pno);
        Parts p = StoryModel.getPartContent(sid, pno);
    %>
    <div class="container-fluid">
        <p class="title">Start writing your own masterpiece</p>
        <div class="row">
            <div class="col-sm-3">
                <img src="Images/girlonbooks.jpg" height="325" width="200" >
            </div>
            <div class="col-sm-6">
                <form action="" method="post" id="frm" enctype="multipart/form-data">
                    <label><b>Part Title: </b></label>
                    <input type="text" name="ptitle" value="<%=p.getPart_title()%>"><br><br>                   
                    <label>Select an image:</label>
                    <input type="file" name="part_img">
                    <br><br>
                    <label><b>Part Content:</b></label><br>
                    <input type="hidden" name="s_id" value="<%= sid%>">
                    <input type="hidden" name="p_no" value="<%= pno%>">
                    <input type="hidden" name="p_desc" id="pdesc">
                    <div id="fTextArea" contenteditable="true"><%=p.getPart_content()%></div>
                    
                    <%
                        if(status.equals("Draft")){
                    %>
                    <button type="submit" onclick="insertData('SaveDraft')" style="width:150px">Save Draft</button>
                    <button type="submit" onclick="insertData('Publish')" style="width:150px">Publish</button>
                    <%
                        }else{
                    %>
                        <button type="submit" onclick="insertData('Save')" style="width:150px"> Save </button>
                    <%
                        }
                    %>
                </form>
            </div> 
            <div class="col-sm-3"></div>  
        </div>
    </div>
<div class="container" style="height:100px"></div>            
    <script>

        function insertData(call_type){
            var div_content=document.getElementById("fTextArea");
            if(div_content.innerHTML==""){
                alert("Please add a description for your story");
            }else{
                var desc = document.getElementById("pdesc");
                desc.value=div_content.innerHTML;
//                alert(desc.value);
                document.getElementById('frm').setAttribute('action',"EditPartServlet?c_type="+call_type);
            }
        }
        
    </script>
</body>
</html>