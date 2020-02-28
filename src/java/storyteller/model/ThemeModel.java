/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import storyteller.dbutil.DBConnection;
import storyteller.pojo.Theme;

/**
 *
 * @author golu
 */
public class ThemeModel {
    public static HashMap<Integer,Theme> getAllThemes() throws SQLException{
        HashMap<Integer,Theme> hm = new HashMap<>();
        Connection con = DBConnection.getConnection();
        String qry="select * from theme";
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(qry);
        
        while(rs.next()){
            Theme t = new Theme();
            t.setTheme_id(rs.getInt(1));
            t.setTheme_name(rs.getString(2));
            hm.put(t.getTheme_id(),t);
        }
       rs.close();
       
        return hm;
    }
}
