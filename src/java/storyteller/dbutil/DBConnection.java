/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn;
    static{
        try{
        Class.forName("oracle.jdbc.OracleDriver");
            String url = "jdbc:oracle:thin:@//dell:1521/XE";
            String username = "minor";
            String password = "MINOR";
            conn = DriverManager.getConnection(url, username, password);
    }catch(Exception e){
        e.printStackTrace();
        }
    }
    
    public static Connection getConnection(){
        return conn;
    }
    
    public static void closeConnection(){
        try{
        conn.close();
        System.out.println("Connection closed!");
        }catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
}

