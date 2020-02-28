<%-- 
    Document   : libraryUpdate
    Created on : Feb 17, 2020, 10:50:05 PM
    Author     : golu
--%>

<%@page import="storyteller.dbutil.DBConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int newCount=0;
            String sid = request.getParameter("SID");
            String call_type = request.getParameter("call_type");
            String user_id =(String) session.getAttribute("user_mail");
            
            Connection con=null;
            ResultSet rs=null;
            boolean Status = false;
            
            
        try{
            con = DBConnection.getConnection();
            if(call_type.equals("Save")){
                
                String save_qry = "update story set no_of_saves=no_of_saves+1 where s_id='"+sid+"'";
                String lib_qry = "insert into library values('"+user_id+"','"+sid+"')";
                Statement st1 = con.createStatement();
                
                int rno1 = st1.executeUpdate(save_qry);
                int rno2 = st1.executeUpdate(lib_qry);
                
                if(rno1>0 && rno2>0){
                    
                    Status = true;
                }else{
                    out.print("can't update");
                }
                
            }
            else{
                String unsave_qry ="update story set no_of_saves=no_of_saves-1 where s_id='"+sid+"'";
                String rem_lib_qry = "delete from library where s_id='"+sid+"' and user_id='"+user_id+"'";
                
                Statement st1 = con.createStatement();
                
                int rno1 = st1.executeUpdate(unsave_qry);
                int rno2 = st1.executeUpdate(rem_lib_qry);
                
                if(rno1>0 && rno2>0){
                    Status = true;
                }else{
                    out.print("can't unsave");
                }
            }
            if(Status){
                String count_qry = "select no_of_saves from story where s_id='"+sid+"'";
                Statement s = con.createStatement();
                
                rs = s.executeQuery(count_qry);
                if(rs.next()){
                    newCount = rs.getInt(1);
                }else{
                    out.print("unable to fetch count");
                }
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }    
        
        %>
        
        <span><%= newCount%></span>
    </body>
</html>
