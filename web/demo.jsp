<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="storyteller.model.ThemeModel"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="storyteller.pojo.Theme"%>

<!DOCTYPE html>
<html>

<head>
    <title> demo filters</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS_Styles/home.css">
    
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <div class="filter_div">
            <h4 id="filter">Filter</h4>
            <p><%=session.getAttribute("user_mail")%></p>
            <form action="demo.jsp?filter=1">
            <p class="title_chk">According to Theme:</p>

            <div class="div_chk">
                <%
                    HashMap<Integer,Theme> tList = ThemeModel.getAllThemes();
                    for(Map.Entry<Integer,Theme> e:tList.entrySet()){
                        int tid = e.getKey();
                        Theme th = e.getValue();
                %>
                <input type="checkbox" name="<%=th.getTheme_name()%>" value="<%=th.getTheme_id()%>"> <%=th.getTheme_name()%><br>
                <%
                    }
                %>
            </div>

            <br>
            <p class="title_chk">According to Rating:</p>
            <div class="div_chk">
                <input type="radio" name="popularity" value="most_popular">Most Popular<br>
                <input type="radio" name="popularity" value="avg">Average<br>
                <input type="radio" name="popularity" value="least_popular">Least Popular<br>
            </div>
            <br>
            <p class="title_chk">According to date:</p>
            From:<br><input type="date" name="from"><br>
            To:<br><input type="date" name="to"><br><br>
            <input type="hidden" name="filter" value="1">
            <input type="submit" value="Apply">
            </form>
        </div>
            <%
                String pop = request.getParameter("popularity");
               String fdate=null;
               String di = request.getParameter("from");
//               int n=0;
//               ArrayList<Integer> arr=new ArrayList<>();
//                if(request.getParameter("filter")!=null){
                if( di==null || di.equals("")){
                    fdate="nothing";
                    
                }
                  else{
                      String strdate = request.getParameter("from");
                    java.sql.Date d = java.sql.Date.valueOf(di);
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                    fdate = sdf.format(d);
//                    fdate="dome";
                  }
//                    try{
//                        Connection conn = DBConnection.getConnection();
//                        String str = "select count(*) from story where date_modified='"+fdate+"'";
//                        Statement st =conn.createStatement();
////                        PreparedStatement ps = conn.prepareStatement("select count(*) from story where date_modified=?");
//                        
//                        ResultSet rs = st.executeQuery(str);
//
//                        if(rs.next()){
//                            n=rs.getInt(1);
//                        }
//
//                    }catch(SQLException ex){
//                        ex.printStackTrace();    
//                    }
//                }
            %>
            <p><%=fdate%></p>
            
        
</body>

</html>