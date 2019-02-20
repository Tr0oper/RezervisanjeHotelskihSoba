package Models;

/**
 *
 * @author Pavle
 */
public class Korisnik {

    private Integer Id;
    private String Ime;
    private String Prezime;
    private String KorisnickoIme;
    private String Sifra;
    private String Email;
    private String Drzava;
    private String Grad;
    private String Telefon;
    private String Adresa;
    private Integer Poeni;
    private String PostanskiBroj;
    private String Rola;
    private Integer HotelID;

    public Korisnik() {
    }

    public Korisnik(Integer Id, String Ime, String Prezime, String KorisnickoIme, String Sifra, String Email,
            String Drzava, String Grad, String Telefon, String Adresa, Integer Poeni, String PostanskiBroj,
            String Rola, Integer HotelID) {
        this.Id = Id;
        this.Ime = Ime;
        this.Prezime = Prezime;
        this.KorisnickoIme = KorisnickoIme;
        this.Sifra = Sifra;
        this.Email = Email;
        this.Drzava = Drzava;
        this.Grad = Grad;
        this.Telefon = Telefon;
        this.Adresa = Adresa;
        this.Poeni = Poeni;
        this.PostanskiBroj = PostanskiBroj;
        this.Rola = Rola;
        this.HotelID = HotelID;
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer Id) {
        this.Id = Id;
    }

    public String getIme() {
        return Ime;
    }

    public void setIme(String Ime) {
        this.Ime = Ime;
    }

    public String getPrezime() {
        return Prezime;
    }

    public void setPrezime(String Prezime) {
        this.Prezime = Prezime;
    }

    public String getKorisnickoIme() {
        return KorisnickoIme;
    }

    public void setKorisnickoIme(String KorisnickoIme) {
        this.KorisnickoIme = KorisnickoIme;
    }

    public String getSifra() {
        return Sifra;
    }

    public void setSifra(String Sifra) {
        this.Sifra = Sifra;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getDrzava() {
        return Drzava;
    }

    public void setDrzava(String Drzava) {
        this.Drzava = Drzava;
    }

    public String getGrad() {
        return Grad;
    }

    public void setGrad(String Grad) {
        this.Grad = Grad;
    }

    public String getTelefon() {
        return Telefon;
    }

    public void setTelefon(String Telefon) {
        this.Telefon = Telefon;
    }

    public String getAdresa() {
        return Adresa;
    }

    public void setAdresa(String Adresa) {
        this.Adresa = Adresa;
    }

    public Integer getPoeni() {
        return Poeni;
    }

    public void setPoeni(Integer Poeni) {
        this.Poeni = Poeni;
    }

    public String getPostanskiBroj() {
        return PostanskiBroj;
    }

    public void setPostanskiBroj(String PostanskiBroj) {
        this.PostanskiBroj = PostanskiBroj;
    }

    public String getRola() {
        return Rola;
    }

    public void setRola(String Rola) {
        this.Rola = Rola;
    }

    public Integer getHotelID() {
        return HotelID;
    }

    public void setHotelID(Integer HotelID) {
        this.HotelID = HotelID;
    }
}
