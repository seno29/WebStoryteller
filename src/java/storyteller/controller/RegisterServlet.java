/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import storyteller.model.LoginModel;
import storyteller.pojo.User;

/**
 *
 * @author golu
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pass=request.getParameter("pass");
        String con_pass=request.getParameter("con_pass");
        String email=request.getParameter("email");
        String name=request.getParameter("name");
        HttpSession session = request.getSession();
        
        if(pass.equals(con_pass)){
            
            User u = new User();
            u.setFull_name(name);
            u.setEmail(email);
            u.setPassword(pass);
            try{
                boolean status = LoginModel.registerUser(u);
                if(status){                    
                    session.setAttribute("user_mail",email);
                    response.sendRedirect("index.html");
                }else{
                    response.sendRedirect("registerForm.jsp?is_register=false");
                }
            }catch(SQLException ex){
                ex.printStackTrace();
            }
        }else{
            response.sendRedirect("registerForm.jsp?is_pass_match=false");
        }
    }
}
