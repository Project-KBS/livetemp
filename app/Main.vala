using WideWorldImporters.LiveTemp;
using WideWorldImporters.LiveTemp.Internal;

/**
 * Class met de main entry point.
 */
public class WideWorldImporters.LiveTemp.Main {

    /**
     * Main method die we vanuit `main.c` aanroepen.
     */
	public static int32 __vala_main() {
        stdout.printf("\nWide World Importers Live Temp Test\nHuidige temperatuur: %0.2f\n", Sensor.temp_read());

        //Netwerk.post("https://localhost:80/api/v1/hello.php", "ok=1");
        stderr.printf("%s", Netwerk.get("http://localhost/api/v1/product/search.php?zoekterm=USB&limit=1"));

        // TODO maak loop en POST naar de website temperatuur API endpoint elke N minuten

        return 69;
    }

}