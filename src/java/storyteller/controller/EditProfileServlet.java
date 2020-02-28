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

@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        Connection con=null;
        Scanner sc;
        HttpSession session = request.getSession();
        
        Part pfull_name = request.getPart("full_name");
        Part pemail = request.getPart("email_id");
        Part pbio = request.getPart("bio");
        Part pimg = request.getPart("pro_img");
        
        sc = new Scanner(pfull_name.getInputStream());
        String full_name = sc.nextLine();
        
        sc = new Scanner(pemail.getInputStream());
        String email = sc.nextLine();
        
        sc = new Scanner(pbio.getInputStream());
        String bio = sc.nextLine();
        
//        if(pimg.getSubmittedFileName()=="")
//            out.print("hugfy");
//        
//        out.println(bio);
//        
//        out.println(full_name);
//        out.println(email);
//        out.println(bio);
        try{
            con = DBConnection.getConnection();
            PreparedStatement ps=null;
            if(pimg.getSubmittedFileName()==""){
                ps = con.prepareStatement("update person set full_name=?,email_id=?,bio=? where email_id=?");
                ps.setString(1,full_name);
                ps.setString(2,email);
                ps.setString(3, bio);
                ps.setString(4,(String)session.getAttribute("user_mail"));
            }else{           
                ps = con.prepareStatement("update person set full_name=?,email_id=?,bio=?,picture=? where email_id=?");
                ps.setString(1,full_name);
                ps.setString(2,email);
                ps.setString(3, bio);

                InputStream is = pimg.getInputStream();
                ps.setBinaryStream(4, is, (int)pimg.getSize());

                ps.setString(5,(String)session.getAttribute("user_mail"));
            }
            int rno = ps.executeUpdate();
            if(rno>0){
                response.sendRedirect("profile.jsp");
            }else{
                response.sendRedirect("editProfile.jsp");
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
