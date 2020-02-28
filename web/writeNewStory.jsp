<%@page import="java.util.Map"%>
<%@page import="storyteller.model.ThemeModel"%>
<%@page import="java.util.HashMap"%>
<%@page import="storyteller.pojo.Theme"%>
<!DOCTYPE html>
<%
    HashMap<Integer,Theme> thmap=new HashMap<>();
    thmap=ThemeModel.getAllThemes();
%>
<html>
<head>
    <title>Write Story</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS_Styles/write_story.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <!-----------------------Navigation Bar------------------------------>
    
    <ul class="navv">
        <p style="float: left;margin:0px;padding: 2px;"><img src="Images/pic1.png" width="25" height="28"></p>
        <p class="navtitle">The Storyteller</p>
        <li><a href="logout.jsp">Logout</a></li>
        <li><a href="profile.jsp" >My Profile</a></li>
        <li><a href="myLibrary.jsp" >My Library</a></li>
        <li><a href="writeNewStory.jsp" class="active">Write A Story</a></li>
        <li><a href="index.jsp" >Home</a></li>
        
    </ul>

    <div class="container-fluid">
        <p class="title">Start writing your own masterpiece </p>
        <div class="row">
            <div class="col-sm-3">
                <img src="Images/girlonbooks.jpg" height="325" width="200">
                
            </div>
            <div class="col-sm-6">
                <form action="" method="post" id="frm" enctype="multipart/form-data">
                    <label>Give it an eye-catching <b>Title: </b></label>
                    <input type="text" name="title" required><br><br>
                    <label>Select a <b>Theme: </b></label>
                    <select name="th_id">
                        <%
                            for(Map.Entry e:thmap.entrySet()){
                                String tname = ((Theme)e.getValue()).getTheme_name();
                                int tid=(Integer) e.getKey();
                        %>
                        <option value="<%=tid%>"><%= tname%></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>
                    <label>Select a cover image:</label>
                    <input type="file" name="cvr_img">
                    <br><br>
                    <label>Add a short <b>Description:</b></label><br>
                    <input type="hidden" name="s_desc" id="sdesc" required>
                    <div id="fTextArea" contenteditable="true" ></div>
                    <button type="submit" onclick="insertData('AddPart')" >+Add Another Part</button>
                    <button type="submit" onclick="insertData('SaveDraft')">Save Draft</button>
                </form>
            </div> 
            <div class="col-sm-3"></div>  
        </div>
    </div>
    <script>

        function insertData(call_type){
            var div_content=document.getElementById("fTextArea");
            if(div_content.innerHTML==""){
                alert("Please add a description for your story");
            }else{
                var desc = document.getElementById("sdesc");
                desc.value=div_content.innerHTML;
//                alert(desc.value);
                document.getElementById('frm').setAttribute('action',"DraftServlet?call_type="+call_type);
            }
        }
        
    </script>
</body>
</html>