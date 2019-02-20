package Models;

import java.sql.Blob;

/**
 *
 * @author Pavle
 */
public class Soba {

    private Integer Id;
    private String BrojSobe;
    private Blob Slika;
    private Integer TipSobeID;
    private Integer Kapacitet;
    private String Opis;
    private String KratkiOpis;
    private Double Cena;
    private Integer Poeni;
    private Integer CenaUPoenima;
    public TipSobe TipSobe = new TipSobe();
    public Hotel Hotel = new Hotel();
    private Integer HotelID;

    public Soba() {
    }

    public Soba(Integer Id, String BrojSobe, Blob Slika, Integer TipSobeID, Integer Kapacitet, String Opis,
            String KratkiOpis, Double Cena, Integer Poeni, Integer CenaUPoenima, Integer HotelID) {
        this.Id = Id;
        this.BrojSobe = BrojSobe;
        this.Slika = Slika;
        this.TipSobeID = TipSobeID;
        this.Kapacitet = Kapacitet;
        this.Opis = Opis;
        this.KratkiOpis = KratkiOpis;
        this.Cena = Cena;
        this.Poeni = Poeni;
        this.CenaUPoenima = CenaUPoenima;
        this.HotelID = HotelID;
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    public String getBrojSobe() {
        return BrojSobe;
    }

    public void setBrojSobe(String BrojSobe) {
        this.BrojSobe = BrojSobe;
    }

    public Blob getSlika() {
        return Slika;
    }

    public void setSlika(Blob Slika) {
        this.Slika = Slika;
    }

    public Integer getTipSobeID() {
        return TipSobeID;
    }

    public void setTipSobeID(Integer TipSobeID) {
        this.TipSobeID = TipSobeID;
    }

    public Integer getKapacitet() {
        return Kapacitet;
    }

    public void setKapacitet(Integer Kapacitet) {
        this.Kapacitet = Kapacitet;
    }

    public String getOpis() {
        return Opis;
    }

    public void setOpis(String Opis) {
        this.Opis = Opis;
    }

    public String getKratkiOpis() {
        return KratkiOpis;
    }

    public void setKratkiOpis(String KratkiOpis) {
        this.KratkiOpis = KratkiOpis;
    }

    public Double getCena() {
        return Cena;
    }

    public void setCena(Double Cena) {
        this.Cena = Cena;
    }

    public Integer getPoeni() {
        return Poeni;
    }

    public void setPoeni(Integer Poeni) {
        this.Poeni = Poeni;
    }

    public Integer getCenaUPoenima() {
        return CenaUPoenima;
    }

    public void setCenaUPoenima(Integer CenaUPoenima) {
        this.CenaUPoenima = CenaUPoenima;
    }

    public TipSobe getTipSobe() {
        return TipSobe;
    }

    public void setTipSobe(TipSobe TipSobe) {
        this.TipSobe = TipSobe;
    }

    public Hotel getHotel() {
        return Hotel;
    }

    public void setHotel(Hotel Hotel) {
        this.Hotel = Hotel;
    }

    public Integer getHotelID() {
        return HotelID;
    }

    public void setHotelID(Integer HotelID) {
        this.HotelID = HotelID;
    }
    
}
