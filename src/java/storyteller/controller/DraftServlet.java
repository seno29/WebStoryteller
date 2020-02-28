/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import storyteller.dbutil.DBConnection;
import storyteller.model.StoryModel;

/**
 *
 * @author golu
 */
@MultipartConfig
public class DraftServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         PrintWriter out = response.getWriter();
//        out.println(request.getParameter("title"));
//        out.println(request.getParameter("s_desc"));
//        out.println(request.getParameter("th_id"));
//        out.println(request.getParameter("cvr_img"));
    HttpSession session = request.getSession(); 
    Scanner sc;
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into story values(?,?,?,?,?,?,?,?,?,?,?,?)");
            String sid=StoryModel.genrateSID();
            
            ps.setString(1, sid);
            
            Part title = request.getPart("title");
            Part s_desc = request.getPart("s_desc");
            Part th_id = request.getPart("th_id");
            Part img = request.getPart("cvr_img");
            
            sc=new Scanner(th_id.getInputStream());
            ps.setInt(2,sc.nextInt());
            
            sc=new Scanner(title.getInputStream());
            ps.setString(3,sc.nextLine());
            
            sc=new Scanner(s_desc.getInputStream());
            ps.setString(4,sc.nextLine());
            
            String author = (String)session.getAttribute("user_mail");    
            ps.setString(5,author);
            
            ps.setInt(6,0);
            ps.setInt(7,0);
            ps.setInt(8,0);
            
            
            ps.setString(9,"Draft");
            //date
            long millis=System.currentTimeMillis();  
            java.sql.Date date=new java.sql.Date(millis); 
            ps.setDate(10,date);
            
            InputStream is = img.getInputStream();
            ps.setBinaryStream(11, is, (int)img.getSize());
            
            ps.setInt(12,0);
            int r_no = ps.executeUpdate();
            String ctype = request.getParameter("call_type");
            if(r_no>0){
                if(ctype.equals("SaveDraft")){
                    response.sendRedirect("index.jsp");
                }else{
                    response.sendRedirect("AddPart.jsp?SID="+sid);
                }
            }else{
                System.out.println("not done");
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
    }

}
