using WideWorldImporters.LiveTemp.Model;
using WideWorldImporters.LiveTemp.Impl.Internal;

/**
 * Een sensor implementatie voor de Raspberry Pi Sense Hat sensor.
 */
public class WideWorldImporters.LiveTemp.Impl.SenseHatSensor : Object, ISensor<double?> {

    private static SenseHatSensor? instance;

    public static SenseHatSensor get_instance() {
        if (instance == null) {
            instance = new SenseHatSensor();
        }
        return (!) instance;
    }

    public Meting<double?> read() {
        return new Meting<double?>(true, Sensor.temp_read());
    }

}