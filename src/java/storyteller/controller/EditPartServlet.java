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
public class EditPartServlet extends HttpServlet {

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
        Scanner sc;
        Connection conn = DBConnection.getConnection();
        Part ptitle = request.getPart("ptitle");
        Part p_desc = request.getPart("p_desc");
        Part img = request.getPart("part_img");
        
        Part sid = request.getPart("s_id");
        sc = new Scanner(sid.getInputStream());
        String SID = sc.nextLine();
        
        Part pno = request.getPart("p_no");
        sc = new Scanner(pno.getInputStream());
        int pnum = Integer.parseInt(sc.nextLine());
        
        String ct = request.getParameter("c_type");
        int rno=0;
        
        try{
            if(img.getSubmittedFileName()!=""){
                PreparedStatement ps = conn.prepareStatement("update parts set part_title=?,content=?,img=? where s_id=? and part_no=?");

                sc = new Scanner(ptitle.getInputStream());
                ps.setString(1,sc.nextLine());

                sc = new Scanner(p_desc.getInputStream());
                ps.setString(2,sc.nextLine());

                InputStream is = img.getInputStream();
                ps.setBinaryStream(3, is, (int)img.getSize());

                ps.setString(4,SID);
                ps.setInt(5,pnum);
                rno = ps.executeUpdate();
                
            }else{
                PreparedStatement ps = conn.prepareStatement("update parts set part_title=?,content=? where s_id=? and part_no=?");

                sc = new Scanner(ptitle.getInputStream());
                ps.setString(1,sc.nextLine());

                sc = new Scanner(p_desc.getInputStream());
                ps.setString(2,sc.nextLine());

                ps.setString(3,SID);
                ps.setInt(4,pnum);
                rno = ps.executeUpdate();
            }
            
            if(rno>0){
                if(ct.equals("Publish")){
                    Statement stmt = conn.createStatement();
                    String qry_up = "update parts set status='Publish' where s_id='"+SID+"' and part_no<="+pnum;
                    int rn = stmt.executeUpdate(qry_up);   
                        response.sendRedirect("editStory.jsp?SID="+SID);
                }else{
                    response.sendRedirect("editStory.jsp?SID="+SID);
                }    
            }else{
                response.sendRedirect("editPart.jsp?SID="+SID+"&PNO="+pnum);
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
