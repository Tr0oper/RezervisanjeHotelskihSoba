package Models;

/**
 *
 * @author Pavle
 */
public class Datumi {

    private String DatumDolaska;
    private String DatumOdlaska;

    public Datumi() {

    }

    public Datumi(String DatumDolaska, String DatumOdlaska) {
        this.DatumDolaska = DatumDolaska;
        this.DatumOdlaska = DatumOdlaska;
    }

    public void setDatumDolaska(String DatumDolaska) {
        this.DatumDolaska = DatumDolaska;
    }

    public String getDatumDolaska() {
        return this.DatumDolaska;
    }

    public void setDatumOdlaska(String DatumOdlaska) {
        this.DatumOdlaska = DatumOdlaska;
    }

    public String getDatumOdlaska() {
        return this.DatumOdlaska;
    }
}
