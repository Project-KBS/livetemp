/**
 * Een generic opslagklasse voor het opslaan van de meting.
 *
 * Sommige sensoren zullen double resultaten geven en sommige int/long, hiervoor is het generic gemaakt.
 */
public class WideWorldImporters.LiveTemp.Model.Meting<T> {

    /**
     * Of de meting successvol was.
     */
    public bool success;

    /**
     * Het resultaat van de meting.
     */
    public T resultaat { get; set; }

    public Meting(bool success, T resultaat) {
        this.success = success;
        this.resultaat = resultaat;
    }
}