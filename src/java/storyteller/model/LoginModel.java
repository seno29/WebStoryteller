/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import storyteller.dbutil.DBConnection;
import storyteller.pojo.User;

/**
 *
 * @author golu
 */
public class LoginModel {
    public static boolean validateLogin(String password, String uname,String type) throws SQLException{
            Connection con = DBConnection.getConnection();
            
            if(type.equals("User")){
                String query = "Select password from person where email_id=?";
                PreparedStatement stmt = con.prepareStatement(query);           
                stmt.setString(1, uname);
                ResultSet rs = stmt.executeQuery();
                if(rs.next()){
                    String pass = rs.getString(1);
    //                out.println(pass);
                    if(pass.equals(password)){

                        rs.close();
                        return true;
                    }else{

                        rs.close();
                        return false;
                    }
                }else{

                    rs.close();
                    return false;
                }
            }else{
                String query = "Select password from admin where email_id=?";
                PreparedStatement stmt = con.prepareStatement(query);           
                stmt.setString(1, uname);
                ResultSet rs = stmt.executeQuery();
                if(rs.next()){
                    String pass = rs.getString(1);
    //                out.println(pass);
                    if(pass.equals(password)){

                        rs.close();
                        return true;
                    }else{

                        rs.close();
                        return false;
                    }
                }else{

                    rs.close();
                    return false;
                }    
            }
    }
    
    public static boolean registerUser(User u) throws SQLException{
        Connection con = DBConnection.getConnection();
        String query = "insert into person values(?,?,?,null,null)";
        PreparedStatement stmt = con.prepareStatement(query);           
        stmt.setString(1, u.getFull_name());
        stmt.setString(2, u.getEmail());
        stmt.setString(3, u.getPassword());
        
        int x = stmt.executeUpdate();
        if(x>0){
            
            return true;
        }else{
            
            return false;
        }
    }
    
}
