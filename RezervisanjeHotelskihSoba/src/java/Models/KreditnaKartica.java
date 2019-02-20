package Models;

/**
 *
 * @author Pavle
 */
public class KreditnaKartica {

    private String Vrsta;
    private String BrojRacuna;
    private Integer MesecIsteka;
    private Integer GodinaIsteka;

    public KreditnaKartica() {

    }

    public KreditnaKartica(String Vrsta, String BrojRacuna, Integer MesecIsteka, Integer GodinaIsteka) {
        this.Vrsta = Vrsta;
        this.BrojRacuna = BrojRacuna;
        this.MesecIsteka = MesecIsteka;
        this.GodinaIsteka = GodinaIsteka;
    }

    public void setVrsta(String Vrsta) {
        this.Vrsta = Vrsta;
    }

    public String getVrsta() {
        return this.Vrsta;
    }

    public void setBrojRacuna(String BrojRacuna) {
        this.BrojRacuna = BrojRacuna;
    }

    public String getBrojRacuna() {
        return this.BrojRacuna;
    }

    public Integer getMesecIsteka() {
        return this.MesecIsteka;
    }

    public void setMesecIsteka(Integer MesecIsteka) {
        this.MesecIsteka = MesecIsteka;
    }

    public Integer getGodinaIsteka() {
        return this.GodinaIsteka;
    }

    public void setGodinaIsteka(Integer GodinaIsteka) {
        this.GodinaIsteka = GodinaIsteka;
    }
}
