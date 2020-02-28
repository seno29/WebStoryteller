<%-- 
    Document   : follow
    Created on : Feb 22, 2020, 10:53:02 PM
    Author     : golu
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String follower_id = (String) session.getAttribute("user_mail");
    String user_id = request.getParameter("f_id");
    String ct = request.getParameter("call_type");
    Connection con = DBConnection.getConnection();
    
    try{
    if(ct.equals("follow")){
        PreparedStatement ps = con.prepareStatement("insert into follow values(?,?)");
        ps.setString(1,user_id);
        ps.setString(2,follower_id);
        
        int rn = ps.executeUpdate();
        if(rn>0){
            out.print("Unfollow");
        }
    }else{
        PreparedStatement ps = con.prepareStatement("delete from follow where user_id=? and follower_id=?");
        ps.setString(1,user_id);
        ps.setString(2,follower_id);
        
        int rn = ps.executeUpdate();
        if(rn>0){
            out.print("Follow");
        }
    }
    }catch(SQLException ex){
        ex.printStackTrace();
    }

%>