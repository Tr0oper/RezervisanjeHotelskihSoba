package Models;


/**
 *
 * @author Pavle
 */
public class Rezervacija {

    private Integer Id;
    private String DatumDolaska;
    private String DatumOdlaska;
    private String VremeOdlaska;
    private Double Novac;
    private Integer BrojOdraslih;
    private Integer BrojDece;
    private boolean StatusRezervacije;
    private Integer KorisnikId;
    public Soba soba = new Soba();
    private Integer SobaID;
    public Korisnik klijent = new Korisnik();
    private Integer Poeni;

    public Rezervacija() {
    }

    public Rezervacija(Integer Id, String DatumDolaska, String DatumOdlaska, String VremeOdlaska, Double Novac, 
            Integer BrojOdraslih, Integer BrojDece, boolean StatusRezervacije, Integer KorisnikId, Integer SobaID, 
            Integer Poeni) {
        this.Id = Id;
        this.DatumDolaska = DatumDolaska;
        this.DatumOdlaska = DatumOdlaska;
        this.VremeOdlaska = VremeOdlaska;
        this.Novac = Novac;
        this.BrojOdraslih = BrojOdraslih;
        this.BrojDece = BrojDece;
        this.StatusRezervacije = StatusRezervacije;
        this.KorisnikId = KorisnikId;
        this.SobaID = SobaID;
        this.Poeni = Poeni;
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    public String getDatumDolaska() {
        return DatumDolaska;
    }

    public void setDatumDolaska(String DatumDolaska) {
        this.DatumDolaska = DatumDolaska;
    }

    public String getDatumOdlaska() {
        return DatumOdlaska;
    }

    public void setDatumOdlaska(String DatumOdlaska) {
        this.DatumOdlaska = DatumOdlaska;
    }

    public String getVremeOdlaska() {
        return VremeOdlaska;
    }

    public void setVremeOdlaska(String VremeOdlaska) {
        this.VremeOdlaska = VremeOdlaska;
    }

    public Double getNovac() {
        return Novac;
    }

    public void setNovac(Double Novac) {
        this.Novac = Novac;
    }

    public Integer getBrojOdraslih() {
        return BrojOdraslih;
    }

    public void setBrojOdraslih(Integer BrojOdraslih) {
        this.BrojOdraslih = BrojOdraslih;
    }

    public Integer getBrojDece() {
        return BrojDece;
    }

    public void setBrojDece(Integer BrojDece) {
        this.BrojDece = BrojDece;
    }

    public boolean getStatusRezervacije() {
        return StatusRezervacije;
    }

    public void setStatusRezervacije(boolean StatusRezervacije) {
        this.StatusRezervacije = StatusRezervacije;
    }

    public Integer getKorisnikId() {
        return KorisnikId;
    }

    public void setKorisnikId(Integer KorisnikId) {
        this.KorisnikId = KorisnikId;
    }

    public Integer getSobaID() {
        return SobaID;
    }

    public void setSobaID(Integer SobaID) {
        this.SobaID = SobaID;
    }

    public Integer getPoeni() {
        return Poeni;
    }

    public void setPoeni(Integer Poeni) {
        this.Poeni = Poeni;
    }
}
