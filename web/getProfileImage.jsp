<%-- 
    Document   : getProfileImage
    Created on : Feb 20, 2020, 10:26:51 AM
    Author     : golu
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String user_id = request.getParameter("user_id");
    ResultSet rs=null;
    try{
    Connection con = DBConnection.getConnection();
    String qry = "select picture from person where email_id='"+user_id+"'";
    Statement st = con.createStatement();
    
    
    byte imgData[] = null;
    rs=st.executeQuery(qry);
    
        if(rs.next() && rs!=null){
            Blob b=rs.getBlob("picture");
            imgData=b.getBytes(1,(int)b.length());
        }else{
            out.println("Display Blob Example");
            out.println("image not found for given id>");
            return;
        }
        response.setContentType("image/jpg");
        OutputStream o = response.getOutputStream();
        o.write(imgData);
        o.flush();
        o.close();
    }catch(Exception e){
        e.printStackTrace();
        out.println("Display Blob Example");
        out.println("image not found jgioigo erufor given id>");
        return;
    }finally{
    if(rs!=null){
        rs.close();
    }
}


%>