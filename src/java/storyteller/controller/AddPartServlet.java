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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import storyteller.dbutil.DBConnection;

/**
 *
 * @author golu
 */
@MultipartConfig
public class AddPartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
      //  out.println(request.getParameter("s_id"));
      
        Scanner sc;
        Connection conn = DBConnection.getConnection();
        Part ptitle = request.getPart("ptitle");
        Part p_desc = request.getPart("p_desc");
        Part img = request.getPart("part_img");
        
        Part sid = request.getPart("s_id");
        sc = new Scanner(sid.getInputStream());
        String SID = sc.nextLine();
        
        String ct = request.getParameter("c_type");
        
        try{
            PreparedStatement pst = conn.prepareStatement("select no_of_parts from story where s_id=?");
            pst.setString(1,SID);
            ResultSet rs = pst.executeQuery();
            int nop=0;
            if(rs.next()){
                nop=rs.getInt(1);
            }
            PreparedStatement ps = conn.prepareStatement("insert into parts values(?,?,?,?,?,?)");
            
            ps.setString(1,SID);
            ps.setInt(2,nop+1);
            
            sc = new Scanner(p_desc.getInputStream());
            ps.setString(3,sc.nextLine());
            
            sc = new Scanner(ptitle.getInputStream());
            ps.setString(4,sc.nextLine());
            
            InputStream is = img.getInputStream();
            ps.setBinaryStream(5, is, (int)img.getSize());
            
            if(ct.equals("Publish")){
                ps.setString(6,"Pending");
                Statement st = conn.createStatement();
                String qry1 = "update parts set status='Pending' where part_no<="+nop+" and s_id='"+SID+"'";
                int n_up = st.executeUpdate(qry1);
                if(n_up<0){
                    out.print("Cant update");
                }
            }else{
                ps.setString(6, "Draft");
            }
            
            int r_no = ps.executeUpdate();
            
                        
            if(r_no>0){
                PreparedStatement pstmt=conn.prepareStatement("Update story set no_of_parts=no_of_parts+1 where s_id=?");
                pstmt.setString(1,SID);
                int rn=pstmt.executeUpdate();
                
                if(rn>0 && ct.equals("Publish")){
                    PreparedStatement ps1=conn.prepareStatement("Update Story set status='Pending',date_modified=? where s_id=?");
                    
                    long millis=System.currentTimeMillis();  
                    java.sql.Date date=new java.sql.Date(millis);
                    ps1.setDate(1,date);
                    ps1.setString(2,SID);
                    
                    int rnum = ps1.executeUpdate();
                    if(rnum>0){
                    response.sendRedirect("index.jsp");
                    }else{
                        out.print("not done");
                    }
                }else if(rn>0 && ct.equals("SaveDraft")){
                    response.sendRedirect("profile.jsp");
                }else if(rn>0 && ct.equals("AddAnotherPart")){
                    response.sendRedirect("AddPart.jsp?SID="+SID);
                }else{
                    System.out.println("not done");
                }
            }else{
                System.out.println("not done");
            }    
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
