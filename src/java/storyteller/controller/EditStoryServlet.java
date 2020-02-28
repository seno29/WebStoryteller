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
public class EditStoryServlet extends HttpServlet {

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
        HttpSession session = request.getSession(); 
        Scanner sc;
        int r_no=0;
            Part title = request.getPart("title");
            Part s_desc = request.getPart("s_desc");
            Part th_id = request.getPart("th_id");
            Part img = request.getPart("cvr_img");
            String sid = request.getParameter("SID");
            
        try{
            Connection con = DBConnection.getConnection();
            if(img.getSubmittedFileName()!=""){
            PreparedStatement ps = con.prepareStatement("update story set title=?,theme_id=?,description=?,cover_img=?,date_modified=? where s_id=?");
            
            sc=new Scanner(title.getInputStream());
            ps.setString(1,sc.nextLine());
            
            sc=new Scanner(th_id.getInputStream());
            ps.setInt(2,sc.nextInt());
            
            sc=new Scanner(s_desc.getInputStream());
            ps.setString(3,sc.nextLine());
            
            //date
            long millis=System.currentTimeMillis();  
            java.sql.Date date=new java.sql.Date(millis); 
            ps.setDate(5,date);
            
            InputStream is = img.getInputStream();
            ps.setBinaryStream(4, is, (int)img.getSize());
                       
            ps.setString(6, sid);
            
            r_no = ps.executeUpdate();
            }else{
                PreparedStatement ps = con.prepareStatement("update story set title=?,theme_id=?,description=?,date_modified=? where s_id=?");
            
                sc=new Scanner(title.getInputStream());
                ps.setString(1,sc.nextLine());

                sc=new Scanner(th_id.getInputStream());
                ps.setInt(2,sc.nextInt());

                sc=new Scanner(s_desc.getInputStream());
                ps.setString(3,sc.nextLine());

                //date
                long millis=System.currentTimeMillis();  
                java.sql.Date date=new java.sql.Date(millis); 
                ps.setDate(4,date);

                ps.setString(5, sid);

                r_no = ps.executeUpdate();
            }
            if(r_no>0){
                response.sendRedirect("profile.jsp");
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
