/**
 * Base klasse voor een sensor.
 */
public interface WideWorldImporters.LiveTemp.Model.ISensor<T> : Object {

    /**
     * Lees de sensor uit en return een meting
     *
     * @return Meting object
     */
    public abstract Meting<T> read();

}