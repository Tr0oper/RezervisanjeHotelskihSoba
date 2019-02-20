package Models;

/**
 *
 * @author Pavle
 */
public class TipSobe {
    private Integer Id;
    private String Naziv;
    private Integer HotelID;
    
    public TipSobe(){
    
    }
    
    public TipSobe(Integer Id, String Naziv,Integer HotelID) {
        this.Id = Id;
        this.Naziv = Naziv;
        this.HotelID = HotelID;
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    public String getNaziv() {
        return Naziv;
    }

    public void setNaziv(String Naziv) {
        this.Naziv = Naziv;
    }

    public Integer getHotelID() {
        return HotelID;
    }

    public void setHotelID(Integer HotelID) {
        this.HotelID = HotelID;
    }
    
    
    
    
}
