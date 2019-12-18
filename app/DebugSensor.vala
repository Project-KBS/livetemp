using WideWorldImporters.LiveTemp.Model;
using WideWorldImporters.LiveTemp.Impl.Internal;

/**
 * Een no-op sensor implementatie met vaste return waarde.
 */
public class WideWorldImporters.LiveTemp.Impl.DebugSensor : Object, ISensor<double?> {

    private const double DEFAULT_VALUE = 420.69;

    private static DebugSensor? instance;

    public static DebugSensor get_instance() {
        if (instance == null) {
            instance = new DebugSensor();
        }
        return (!) instance;
    }

    public Meting<double?> read() {
        return new Meting<double?>(true, DEFAULT_VALUE);
    }

}