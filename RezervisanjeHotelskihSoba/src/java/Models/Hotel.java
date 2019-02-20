package Models;

import java.sql.Blob;

/**
 *
 * @author Pavle
 */
public class Hotel {

    private Integer Id;
    private String Ime;
    private String Drzava;
    private String Grad;
    private String Adresa;
    private Integer BrojZvezdica;
    private String Opis;
    private Blob Slika;

    public Hotel() {

    }

    public Hotel(Integer Id, String Ime, String Drzava, String Grad, String Adresa, Integer BrojZvezdica, String Opis, Blob Slika) {
        this.Id = Id;
        this.Ime = Ime;
        this.Drzava = Drzava;
        this.Grad = Grad;
        this.Adresa = Adresa;
        this.BrojZvezdica = BrojZvezdica;
        this.Opis = Opis;
        this.Slika = Slika;
    }

    public Integer getHotelId() {
        return Id;
    }

    public void setHotelId(Integer Id) {
        this.Id = Id;
    }

    public String getIme() {
        return Ime;
    }

    public void setIme(String Ime) {
        this.Ime = Ime;
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

    public String getAdresa() {
        return Adresa;
    }

    public void setAdresa(String Adresa) {
        this.Adresa = Adresa;
    }

    public Integer getBrojZvezdica() {
        return BrojZvezdica;
    }

    public void setBrojZvezdica(Integer BrojZvezdica) {
        this.BrojZvezdica = BrojZvezdica;
    }

    public String getOpis() {
        return Opis;
    }

    public void setOpis(String Opis) {
        this.Opis = Opis;
    }

    public Blob getSlika() {
        return Slika;
    }

    public void setSlika(Blob Slika) {
        this.Slika = Slika;
    }
}
