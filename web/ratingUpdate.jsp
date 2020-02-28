<%-- 
    Document   : ratingUpdate.jsp
    Created on : Dec 23, 2019, 10:03:31 PM
    Author     : golu
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="storyteller.model.StoryModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <body>
<%
    String sid = request.getParameter("SID");
    String call_type = request.getParameter("call_type");
    String user_id = (String) session.getAttribute("user_mail");
    
    Connection con = DBConnection.getConnection();
    String query=null;
    ResultSet rs=null;
    int newRating=0;
    boolean status = false;
try{
    
    if(call_type.equals("Like")){
        String q1 = "update story set rating=rating+1 where s_id="+"'"+sid+"'";
        Statement s1 = con.createStatement();
        int rno = s1.executeUpdate(q1);
        
        String like_qry = "insert into likes values('"+sid+"','"+user_id+"')";
//         String like_qry = "insert into likes values('S101','diksha122@gmail.com')";
        int no_r = s1.executeUpdate(like_qry);
        if(no_r>0 && rno>0){
            status = true; 
        }
        
    }else{
        PreparedStatement ps2 = con.prepareStatement("update story set rating=rating-1 where s_id=?");
        ps2.setString(1, sid);
        int rno = ps2.executeUpdate();
        
        
        String unlike_qry = "delete from likes where s_id='"+sid+"' and user_id='"+user_id+"'";
//        String unlike_qry = "delete from likes where s_id='S121' and user_id='diksha122@gmail.com'";

        Statement s = con.createStatement();
        int no_r = s.executeUpdate(unlike_qry);
        if(no_r>0 && rno>0){
            status = true; 
        }
    }
    
    
    
    
    if(status){
        PreparedStatement ps3 = con.prepareStatement("select rating from story where s_id=?");
        ps3.setString(1,sid);
        rs = ps3.executeQuery();
        
        if(rs.next()){
            newRating = rs.getInt(1);
        }else{
            out.print("Can't get rating");
        }
        
    }else{
        out.print("Can't update");
    }
}catch(SQLException ex){
        ex.printStackTrace();
}finally{
    if(rs!=null){
        rs.close();
    }
}
    
  %>
  <span><%= newRating%></span>
    </body>
</html>