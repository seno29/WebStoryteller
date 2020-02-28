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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.TreeMap;
import storyteller.dbutil.DBConnection;
import storyteller.pojo.Comment;
import storyteller.pojo.Parts;
import storyteller.pojo.Story;

/**
 *
 * @author golu
 */
public class StoryModel {
    public static ArrayList<Story> getAllStories() throws SQLException{
       ArrayList<Story> s = new ArrayList<>();
       Connection con=null;
       Statement st=null;
       ResultSet rs=null;
       try{
       con = DBConnection.getConnection();
       String query = "select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T where S.theme_id = T.theme_id AND S.status = 'Publish' order by S.date_modified desc";
       st = con.createStatement();
       rs = st.executeQuery(query);
       
       while(rs.next()){
           Story s1 = new Story();
           s1.setSid(rs.getString(1));
           s1.setTitle(rs.getString(2));
           s1.setDescription(rs.getString(3));
           s1.setTheme_name(rs.getString(4));
           s1.setAuthor(rs.getString(5));
           s1.setNumParts(rs.getInt(6));
           s1.setNumSaves(rs.getInt(7));
           s1.setNumReads(rs.getInt(8));
           s1.setRating(rs.getInt(9));
           
//           java.sql.Date d=rs.getDate("ord_date");
//            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
//            String dateStr = sdf.format(d);
//            obj.setOrdDate(dateStr);

            java.sql.Date d = rs.getDate(10);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String strDate = sdf.format(d);
            s1.setDate_modified(strDate);
            
            s.add(s1);
       }
       }catch(SQLException ex){
           ex.printStackTrace();
       }
    rs.close();
       return s;
    }
    
    public static ArrayList<Story> getPendingStories() throws SQLException{
        ArrayList<Story> sList = new ArrayList<>();
        Connection con=null;
       Statement st=null;
       ResultSet rs=null;
       try{
       con = DBConnection.getConnection();
       String query = "select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T where S.theme_id = T.theme_id AND S.status = 'Pending' order by S.date_modified desc";
       st = con.createStatement();
       rs = st.executeQuery(query);
       
       while(rs.next()){
           Story s1 = new Story();
           s1.setSid(rs.getString(1));
           s1.setTitle(rs.getString(2));
           s1.setDescription(rs.getString(3));
           s1.setTheme_name(rs.getString(4));
           s1.setAuthor(rs.getString(5));
           s1.setNumParts(rs.getInt(6));
           s1.setNumSaves(rs.getInt(7));
           s1.setNumReads(rs.getInt(8));
           s1.setRating(rs.getInt(9));
            java.sql.Date d = rs.getDate(10);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String strDate = sdf.format(d);
            s1.setDate_modified(strDate);
            
            sList.add(s1);
        }
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        rs.close();        
        return sList;
    }
    
    
    
    public static ArrayList<Story> getAllStoriesByAuthor(String auth_id) throws SQLException{
       ArrayList<Story> s = new ArrayList<>();
       Connection con=null;
       Statement st=null;
       ResultSet rs=null;
       try{
       con = DBConnection.getConnection();
       String query = "select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T where S.author='"+auth_id+"' AND S.theme_id = T.theme_id AND S.status = 'Publish' order by S.date_modified desc";
       st = con.createStatement();
       rs = st.executeQuery(query);
       
       while(rs.next()){
           Story s1 = new Story();
           s1.setSid(rs.getString(1));
           s1.setTitle(rs.getString(2));
           s1.setDescription(rs.getString(3));
           s1.setTheme_name(rs.getString(4));
           s1.setAuthor(rs.getString(5));
           s1.setNumParts(rs.getInt(6));
           s1.setNumSaves(rs.getInt(7));
           s1.setNumReads(rs.getInt(8));
           s1.setRating(rs.getInt(9));
           
//           java.sql.Date d=rs.getDate("ord_date");
//            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
//            String dateStr = sdf.format(d);
//            obj.setOrdDate(dateStr);

            java.sql.Date d = rs.getDate(10);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String strDate = sdf.format(d);
            s1.setDate_modified(strDate);
            
            s.add(s1);
       }
       }catch(SQLException ex){
           ex.printStackTrace();
       }
       rs.close();
       return s;
    }
    
    public static ArrayList<Story> getAllSavedStories(String user_id){
        ArrayList<Story> savedStories = new ArrayList<>();
        
       Connection con=null;
       Statement st=null;
       ResultSet rs=null;
       try{
       con = DBConnection.getConnection();
       String query = "select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T, Library L where S.theme_id = T.theme_id AND S.status = 'Publish' AND S.s_id=L.s_id AND L.user_id='"+user_id+"' order by S.date_modified desc";
       st = con.createStatement();
       rs = st.executeQuery(query);
       
       while(rs.next()){
           Story s1 = new Story();
           s1.setSid(rs.getString(1));
           s1.setTitle(rs.getString(2));
           s1.setDescription(rs.getString(3));
           s1.setTheme_name(rs.getString(4));
           s1.setAuthor(rs.getString(5));
           s1.setNumParts(rs.getInt(6));
           s1.setNumSaves(rs.getInt(7));
           s1.setNumReads(rs.getInt(8));
           s1.setRating(rs.getInt(9));
           
//           java.sql.Date d=rs.getDate("ord_date");
//            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
//            String dateStr = sdf.format(d);
//            obj.setOrdDate(dateStr);

            java.sql.Date d = rs.getDate(10);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String strDate = sdf.format(d);
            s1.setDate_modified(strDate);
            
            savedStories.add(s1);
       }
       }catch(SQLException ex){
           ex.printStackTrace();
       }
      
        return savedStories;
    }
    public static TreeMap<Integer,String> getAllPartsBySid(String sid){
        TreeMap<Integer,String> parts = new TreeMap<>();
        Connection con = DBConnection.getConnection();
        try{
            Statement st = con.createStatement();
            String qry = "select part_no,part_title from parts where s_id='"+sid+"' order by part_no";
            ResultSet rs = st.executeQuery(qry);
            
            while(rs.next()){
                parts.put(rs.getInt(1),rs.getString(2));
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        return parts;
    }
    
    
    public static ArrayList<Story> getAllDraftStories(String auth_id) throws SQLException{
       ArrayList<Story> s = new ArrayList<>();
       Connection con=null;
       Statement st=null;
       ResultSet rs=null;
       try{
       con = DBConnection.getConnection();
       String query = "select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T where S.author='"+auth_id+"' AND S.theme_id = T.theme_id AND S.status = 'Draft' order by S.date_modified desc";
       st = con.createStatement();
       rs = st.executeQuery(query);
       
       while(rs.next()){
           Story s1 = new Story();
           s1.setSid(rs.getString(1));
           s1.setTitle(rs.getString(2));
           s1.setDescription(rs.getString(3));
           s1.setTheme_name(rs.getString(4));
           s1.setAuthor(rs.getString(5));
           s1.setNumParts(rs.getInt(6));
           s1.setNumSaves(rs.getInt(7));
           s1.setNumReads(rs.getInt(8));
           s1.setRating(rs.getInt(9));

            java.sql.Date d = rs.getDate(10);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String strDate = sdf.format(d);
            s1.setDate_modified(strDate);
            
            s.add(s1);
       }
       }catch(SQLException ex){
           ex.printStackTrace();
       }
    
       return s;
    }
    
    public static String genrateSID() throws SQLException{
        String sid="";
        Connection con = DBConnection.getConnection();
        String qry="select count(*) from story";
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(qry);
        int id=100;
        while(rs.next()){
            id=id+rs.getInt(1);
        }
        id++;
        sid="S"+id;
        return sid;
        
    } 
    
    public static TreeMap<Integer,String> getAllPartsTitle(String sid) throws SQLException{
        TreeMap<Integer,String> partsTitle = new TreeMap<>();
        Connection con=DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("select part_no,part_title from parts where s_id=? and status='Publish'");
        ps.setString(1,sid);
        
        ResultSet rs = ps.executeQuery();
        
        while(rs.next()){
            partsTitle.put(rs.getInt(1),rs.getString(2));
        }
        rs.close();
        return partsTitle;
    }
    
    public static TreeMap<Integer,String> getAllPendingPartsTitle(String sid) throws SQLException{
        TreeMap<Integer,String> partsTitle = new TreeMap<>();
        Connection con=DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("select part_no,part_title from parts where s_id=? and status!='Draft'");
        ps.setString(1,sid);
        
        ResultSet rs = ps.executeQuery();
        
        while(rs.next()){
            partsTitle.put(rs.getInt(1),rs.getString(2));
        }
        rs.close();
        return partsTitle;
    }
    
    public static Parts getPartContent(String sid,int pno) throws SQLException{
        String content=null;
        Connection con=DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("select part_title,content from parts where s_id=? and part_no=?");
        ps.setString(1,sid);
        ps.setInt(2,pno);
        
        Parts p=new Parts();
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            p.setPart_title(rs.getString(1));
            p.setPart_content(rs.getString(2));
        }
        p.setPid(pno);
        
        return p;
    }
    
    public static boolean isValidPartNo(String sid,int pno) throws SQLException{
        boolean isValid=false;
        Connection con=DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("select part_no from parts where s_id=? and part_no=? and status='Publish'");
        ps.setString(1,sid);
        ps.setInt(2,pno);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            isValid=true;
        }else{
            isValid=false;
        }        
        return isValid;
    }
    public static boolean isValidPendingPartNo(String sid,int pno) throws SQLException{
        boolean isValid=false;
        Connection con=DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("select part_no from parts where s_id=? and part_no=? and status!='Draft'");
        ps.setString(1,sid);
        ps.setInt(2,pno);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            isValid=true;
        }else{
            isValid=false;
        }        
        return isValid;
    }
    
    public static int getNumOfParts(String sid){
        int num=0;
        Connection con = DBConnection.getConnection();
        
        try{
            Statement st = con.createStatement();
            String qry = "select count(*) from parts where s_id='"+sid+"' and status='Publish'";
            ResultSet rs = st.executeQuery(qry);
            if(rs.next()){
                num = rs.getInt(1);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return num;
    }
    
    public static int getNumOfPendingParts(String sid){
        int num=0;
        Connection con = DBConnection.getConnection();
        
        try{
            Statement st = con.createStatement();
            String qry = "select count(*) from parts where s_id='"+sid+"' and status!='Draft'";
            ResultSet rs = st.executeQuery(qry);
            if(rs.next()){
                num = rs.getInt(1);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return num;
    }
    
    public static String getPartStatus(String sid,int pno){
        String status = "";
        Connection conn = DBConnection.getConnection();
        
        try{
            String qry = "select status from parts where s_id='"+sid+"' and part_no="+pno;
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(qry);
            if(rs.next()){
                status = rs.getString(1);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return status;
    }
    
    public static HashSet<String> getAllLikes(String user) {
        HashSet<String> storiesLikedSet = new HashSet<>();
        Connection con = DBConnection.getConnection();
        
        try{
            PreparedStatement ps = con.prepareCall("select s_id from likes where user_id=?");
            ps.setString(1,user);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                storiesLikedSet.add(rs.getString(1));
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return storiesLikedSet;
    }
    
    public static HashSet<String> getAllSaves(String user) {
        HashSet<String> storiesSavedSet = new HashSet<>();
        Connection con = DBConnection.getConnection();
        
        try{
            PreparedStatement ps = con.prepareCall("select s_id from library where user_id=?");
            ps.setString(1,user);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                storiesSavedSet.add(rs.getString(1));
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return storiesSavedSet;
    }
    
    public static boolean deleteStory(String sid){
        boolean status=false;
        Connection con = DBConnection.getConnection();
        try{
            String qry = "delete from parts where s_id='"+sid+"'";
            String qry1 = "delete from story where s_id='"+sid+"'";
            Statement st = con.createStatement();
            int rno = st.executeUpdate(qry);           
            Statement st1 = con.createStatement();
            int rn = st1.executeUpdate(qry1);
            if(rn>0){
                status = true;
            }
           
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return status;
    }
    
    public static Story getStoryById(String sid){
        Story s = new Story();
        Connection conn = DBConnection.getConnection();
        try{
            String qry = "select S.title,T.theme_name,S.description from story S,theme T where s_id='"+sid+"' AND T.theme_id=S.theme_id";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(qry);
            
            if(rs.next()){
                s.setTitle(rs.getString(1));
                s.setTheme_name(rs.getString(2));
                s.setDescription(rs.getString(3));               
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        
        return s;
    }
    
    public static ArrayList<Story> getfilteredStories(ArrayList<Integer> tid, String popularity,String from,String to){
        ArrayList<Story> sList = new ArrayList<>();
        String qry="select S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T where S.theme_id = T.theme_id AND S.status = 'Publish' ";
        
        if(tid.size()!=0){
            qry = qry+"AND (S.theme_id="+tid.get(0); 
            
            for(int i=0;i<tid.size();i++){
                qry=qry+" OR S.theme_id="+tid.get(i);
            }
            qry=qry+")";
        }
        
        if((from!=null && to!=null) && (!(from.equals("")) && !(to.equals("")))){
            java.sql.Date d = java.sql.Date.valueOf(from);
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String fdate = sdf.format(d);

            java.sql.Date dt = java.sql.Date.valueOf(to);
            SimpleDateFormat sdft = new SimpleDateFormat("dd-MMM-yyyy");
            String tdate = sdft.format(dt);
        
            qry=qry+" AND date_modified BETWEEN '"+fdate+"'"+" AND '"+tdate+"'";
        }
        if(popularity!=null && !(popularity.equals(""))){
            if(popularity.equals("most_popular")){
                qry=qry+" order by S.rating desc";
            }else if(popularity.equals("least_popular")){
                qry=qry+" order by S.rating";
            }
        }
        
        Connection con = DBConnection.getConnection();
        try{
            Statement st = con.createStatement();
            st = con.createStatement();
            ResultSet rs = st.executeQuery(qry);
       
            while(rs.next()){
                Story s1 = new Story();
                s1.setSid(rs.getString(1));
                s1.setTitle(rs.getString(2));
                s1.setDescription(rs.getString(3));
                s1.setTheme_name(rs.getString(4));
                s1.setAuthor(rs.getString(5));
                s1.setNumParts(rs.getInt(6));
                s1.setNumSaves(rs.getInt(7));
                s1.setNumReads(rs.getInt(8));
                s1.setRating(rs.getInt(9));

                 java.sql.Date d = rs.getDate(10);
                 SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                 String strDate = sdf.format(d);
                 s1.setDate_modified(strDate);

                 sList.add(s1);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return sList;
    }
    
    public static ArrayList<Comment> getAllComments(String sid,int pno){
        ArrayList<Comment> comList = new ArrayList<>(); 
        Connection con = DBConnection.getConnection();
        String qry = "select user_id,content,date_posted from comments where s_id='"+sid+"' AND p_no="+pno+"order by date_posted";
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qry);
            
            while(rs.next()){
                Comment c = new Comment();
                c.setUser_id(rs.getString(1));
                c.setContent(rs.getString(2));
                
                java.sql.Timestamp ts = rs.getTimestamp(3);
                java.util.Date d = new java.util.Date(ts.getTime());
                String strdate = d.toString();
                c.setDate_posted(strdate);
                
                comList.add(c);
            }
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }   
        return comList;        
    }
    
    public static ArrayList<Story> getMatchedStories(String query){
        ArrayList<Story> sList = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String qry = "select distinct S.S_id,S.title, S.description, T.theme_name, S.author, S.No_of_parts, S.No_of_saves, S.No_of_reads, S.rating, S.date_modified from Story S, Theme T,Person P where S.theme_id = T.theme_id AND S.status = 'Publish' AND S.author=P.email_id AND (P.full_name LIKE '%"+query+"%' OR S.description LIKE '%"+query+"%' OR S.title LIKE '%"+query+"%') order by S.date_modified desc";
        
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qry);
       
            while(rs.next()){
                Story s1 = new Story();
                s1.setSid(rs.getString(1));
                s1.setTitle(rs.getString(2));
                s1.setDescription(rs.getString(3));
                s1.setTheme_name(rs.getString(4));
                s1.setAuthor(rs.getString(5));
                s1.setNumParts(rs.getInt(6));
                s1.setNumSaves(rs.getInt(7));
                s1.setNumReads(rs.getInt(8));
                s1.setRating(rs.getInt(9));

                 java.sql.Date d = rs.getDate(10);
                 SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                 String strDate = sdf.format(d);
                 s1.setDate_modified(strDate);

                 sList.add(s1);
            }
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return sList;
    }
}
