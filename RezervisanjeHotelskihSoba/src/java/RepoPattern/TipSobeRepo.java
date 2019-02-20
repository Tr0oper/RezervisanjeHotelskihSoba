package RepoPattern;

import DAO.TipSobeDAO;
import Models.TipSobe;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Pavle
 */
public class TipSobeRepo implements TipSobeDAO {

    Connection con;
    String url = "jdbc:mysql://localhost:3306/sobehotela";
    String user = "root";
    String pass = "";
    
    public TipSobeRepo() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TipSobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
   
    @Override
    public ArrayList<TipSobe> lista(String HotelID) throws SQLException{
        
        ArrayList<TipSobe> tipoviSoba = new ArrayList<TipSobe>();
        try {
           
             String select = "select *from TipSobe where HotelID = " + HotelID;
        
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(select);
             
             while(rs.next()){
                 TipSobe tipSobe = new TipSobe();
                 tipSobe.setId(rs.getInt("Id"));
                 tipSobe.setNaziv(rs.getString("Naziv"));
                 tipSobe.setHotelID(rs.getInt("HotelID"));
                 tipoviSoba.add(tipSobe);
             }
 
        } catch (SQLException ex) {
            Logger.getLogger(TipSobeRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
            con.close();
        }
        return tipoviSoba; 
    }
    
    @Override
    public boolean insert(TipSobe ts) throws SQLException, IOException{
        
        String insert = "INSERT INTO `TipSobe`(`Naziv`, `HotelID`) VALUES (?,?)";
        try {
           
            PreparedStatement pst = con.prepareStatement(insert);
            
            pst.setString(1, ts.getNaziv());
            pst.setInt(2, ts.getHotelID());
            
 
            pst.executeUpdate();
           
            return true;
        } 
        catch (SQLException ex) {
            return false;
        }   
    }
    
    @Override
    public boolean delete(String Niz_ID) throws SQLException{
        
        String delete = "delete from  TipSobe where id in (" + Niz_ID +")";
         
        try {   
            PreparedStatement ps  = con.prepareStatement(delete);

            ps.executeUpdate();
            return true;
  
        } catch (SQLException ex) {
            Logger.getLogger(HotelRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
       return false;
    }
}
