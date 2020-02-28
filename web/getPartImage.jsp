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
    try{
    Connection con = DBConnection.getConnection();
    Statement st=con.createStatement();
    PreparedStatement pst = con.prepareStatement("select img from parts where s_id=? and part_no=?");
    
    ResultSet rs=null;
    String s_id;
    int pno;

    s_id=request.getParameter("SID");
    pno = Integer.parseInt(request.getParameter("PNO"));
    
    pst.setString(1,s_id);
    pst.setInt(2, pno);
    
    byte imgData[] = null;
    rs=pst.executeQuery();
    
    if(rs.next() && rs!=null){
        Blob b=rs.getBlob("img");
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

