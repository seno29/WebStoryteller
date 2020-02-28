<%-- 
    Document   : imageDisplay
    Created on : Oct 30, 2019, 3:34:05 PM
    Author     : golu
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    
<%
    Connection con=null;
    ResultSet rs=null;
    try{
    con = DBConnection.getConnection();
    PreparedStatement pst = con.prepareStatement("select cover_img from story where s_id=?");
    
    
    String s_id;

    s_id=request.getParameter("id");
    pst.setString(1,s_id);
 
    byte imgData[] = null;
    rs=pst.executeQuery();
    
    if(rs.next() && rs!=null){
        Blob b=rs.getBlob("cover_img");
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
        }
%>

