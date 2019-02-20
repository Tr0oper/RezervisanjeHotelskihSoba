package DAO;

import Models.MenadzeriHotela;
import java.sql.SQLException;

/**
 *
 * @author Pavle
 */
public interface MenadzerHotelaDAO {
    
    MenadzeriHotela select(Integer KorisnikId) throws SQLException;
    boolean insert(MenadzeriHotela menadzerHotela) throws SQLException;
}
