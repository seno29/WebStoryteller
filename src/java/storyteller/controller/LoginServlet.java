/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import storyteller.dbutil.DBConnection;
import storyteller.model.LoginModel;

/**
 *
 * @author golu
 */
public class LoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String type = request.getParameter("type");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        out.println(email);
        out.println(password);
        try{
        if(LoginModel.validateLogin(password, email, type)){
           
            if(type.equals("User")){
                session.setAttribute("user_mail",email);
                response.sendRedirect("index.jsp");
            }else{
                session.setAttribute("admin_mail",email);
                response.sendRedirect("dashboard.jsp");
            }
        }else{
            //session.setAttribute("isvalid",false);   
            response.sendRedirect("loginForm.jsp?isvalid=false");
        }

        }catch(SQLException ex){
            out.println(ex);
        }   
    }

}
