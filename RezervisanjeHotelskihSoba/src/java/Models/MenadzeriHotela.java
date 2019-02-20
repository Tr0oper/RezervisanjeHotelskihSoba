package Models;

/**
 *
 * @author Pavle
 */
public class MenadzeriHotela {
    
    private Integer Id;
    private Integer KorisnikId;
    private Integer HotelId;

    public MenadzeriHotela(Integer Id, Integer KorisnikId, Integer HotelId) {
        this.Id = Id;
        this.KorisnikId = KorisnikId;
        this.HotelId = HotelId;
    }
    public MenadzeriHotela(){ }
    
    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    public Integer getKorisnikId() {
        return KorisnikId;
    }

    public void setKorisnikId(Integer KorisnikId) {
        this.KorisnikId = KorisnikId;
    }

    public Integer getHotelId() {
        return HotelId;
    }

    public void setHotelId(Integer HotelId) {
        this.HotelId = HotelId;
    }
}
