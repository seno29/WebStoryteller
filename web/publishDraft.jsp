<%-- 
    Document   : publishDraft
    Created on : Feb 22, 2020, 4:21:40 PM
    Author     : golu
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sid=request.getParameter("SID");
    
    long millis=System.currentTimeMillis();  
    java.sql.Date date=new java.sql.Date(millis);
    
    try{
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps= conn.prepareStatement("update story set status='Pending',date_modified=? where s_id=?");
        ps.setDate(1,date);
        ps.setString(2,sid);
        
        int rn= ps.executeUpdate();
        if(rn>0){
            String qry1 = "update parts set status='Pending' where s_id='"+sid+"'";
            Statement st = conn.createStatement();
            int rno = st.executeUpdate(qry1);           
            response.sendRedirect("myDraft.jsp");
        }else{
           out.print("Cant delete Go Back");
        }
    }catch(SQLException ex){
        ex.printStackTrace();
    }

%>