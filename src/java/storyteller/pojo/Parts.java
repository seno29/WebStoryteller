/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package storyteller.pojo;

/**
 *
 * @author golu
 */
public class Parts {
    private int pno;
    private String part_title;
    private String part_content;

    public String getPart_title() {
        return part_title;
    }

    public void setPart_title(String part_title) {
        this.part_title = part_title;
    }
  
    public int getPid() {
        return pno;
    }

    public void setPid(int pno) {
        this.pno = pno;
    }

    public String getPart_content() {
        return part_content;
    }

    public void setPart_content(String part_content) {
        this.part_content = part_content;
    }
    
    
}
