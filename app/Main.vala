using WideWorldImporters.LiveTemp;
using WideWorldImporters.LiveTemp.Model;

using WideWorldImporters.LiveTemp.Impl;

/**
 * Class met de main entry point.
 */
public class WideWorldImporters.LiveTemp.Main : Object {

    /**
     * De standaard sensor die gebruikt wordt.
     */
    public static ISensor<double?>? DEFAULT_SENSOR = SenseHatSensor.get_instance();

    static construct {
        typeof(Soup.Session).ensure();
    }

    /**
     * Main method die we vanuit `main.c` aanroepen.
     */
	public static int32 __vala_main() {

	    // Als deze methode vanuit C opgeroepen is gtype class_init nog niet gedaan.
	    typeof(Main).ensure();
	    if (DEFAULT_SENSOR == null) {
            DEFAULT_SENSOR = new SenseHatSensor();
        }

        stdout.printf("\nWide World Importers Live Temp Test\nHuidige temperatuur: %0.2f\n", (!) ((!) DEFAULT_SENSOR).read().resultaat);

        //Netwerk.post("https://localhost:80/api/v1/hello.php", "ok=1");
        stderr.printf("%s", Netwerk.get("http://localhost/api/v1/product/search.php?zoekterm=USB&limit=1"));

        // TODO maak loop en POST naar de website temperatuur API endpoint elke N minuten

        return 69;
    }

    private Main() {

    }

}