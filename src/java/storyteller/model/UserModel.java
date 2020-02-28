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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import storyteller.dbutil.DBConnection;
import storyteller.pojo.User;

/**
 *
 * @author golu
 */
public class UserModel {
    public static User getUserData(String user_id) {
        User user = new User();
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("select full_name,bio from person where email_id=?");
            ps.setString(1,user_id);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                user.setFull_name(rs.getString(1));
                user.setBio(rs.getString(2));
            }
            
           rs.close(); 
        }catch(SQLException ex){
            ex.printStackTrace();
        }
       
        return user;
    }
    public static String getFullName(String user_id){
        String name="";
        Connection conn = DBConnection.getConnection();
        try{
            Statement st = conn.createStatement();
            String qry ="select full_name from person where email_id='"+user_id+"'";
            ResultSet rs = st.executeQuery(qry);
            if(rs.next()){
                name = rs.getString(1);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return name;
    }
    
    public static HashMap<String,String> getAllFollowers(String user_id){
        HashMap<String,String> followers = new HashMap<>();
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("select P.full_name,F.follower_id from Person P,Follow F where F.user_id=? and F.follower_id=P.email_id");
            ps.setString(1,user_id);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                followers.put(rs.getString(2),rs.getString(1));
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        return followers;
    } 
    
    public static HashMap<String,String> getAllFollowing(String user_id){
        HashMap<String,String> following = new HashMap<>();
        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("select P.full_name,F.user_id from Person P,Follow F where F.follower_id=? and F.user_id=P.email_id");
            ps.setString(1,user_id);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                following.put(rs.getString(2),rs.getString(1));
            }
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        return following;
    }
    
    public static ArrayList<User> getMatchedUsers(String query){
        ArrayList<User> uList = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String qry = "select distinct email_id,full_name,bio from Person where full_name LIKE '%"+query+"%' or email_id LIKE '%"+query+"%'";
        
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qry);
            
            while(rs.next()){
                User u = new User();
                u.setEmail(rs.getString(1));
                u.setFull_name(rs.getString(2));
                u.setBio(rs.getString(3));
                uList.add(u);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        return uList;
    }
}
