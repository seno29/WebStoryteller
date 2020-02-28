<%-- 
    Document   : addComment
    Created on : Feb 23, 2020, 6:50:43 PM
    Author     : golu
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sid = request.getParameter("sid");
    int pno = Integer.parseInt(request.getParameter("pno"));
    String user_id = (String) session.getAttribute("user_mail");
    String cont = request.getParameter("content");
    String stitle = request.getParameter("stitle");
    try{
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("insert into comments values(?,?,?,?,?)");
        ps.setString(1,user_id);


        long millis=System.currentTimeMillis();  
        java.sql.Timestamp date=new java.sql.Timestamp(millis); 
        ps.setTimestamp(2, date);

        ps.setString(3,cont);
        ps.setString(4,sid);
        ps.setInt(5,pno);

        int rno = ps.executeUpdate();
        if(rno>0){
            response.sendRedirect("partContent.jsp?SID="+sid+"&pno="+pno+"&stitle="+stitle);
        }else{
            out.print("unable ro post comment.Go Back");
        }
    }catch(SQLException ex){
        ex.printStackTrace();
    }

%>