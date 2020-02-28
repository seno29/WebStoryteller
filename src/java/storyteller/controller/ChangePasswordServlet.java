/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import storyteller.dbutil.DBConnection;

/**
 *
 * @author golu
 */
public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            String oldP = request.getParameter("old_pass");
            String newP = request.getParameter("new_pass");
            String user_id = (String) session.getAttribute("user_mail");
            
            try{
                String actualP=null;
                Connection con = DBConnection.getConnection();
                String qry = "select password from person where email_id='"+user_id+"'";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(qry);
                if(rs.next()){
                    actualP = rs.getString(1);
                }
//                out.print(actualP);
                if(!actualP.equals(oldP)){
                    response.sendRedirect("changePassword.jsp?pass_changed=false");

                }else{
                    String nextqry = "update person set password='"+newP+"' where email_id='"+user_id+"'";
                    int rn = st.executeUpdate(nextqry);
                    if(rn>0){
                        response.sendRedirect("changePassword.jsp?pass_changed=true");
                    }
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
