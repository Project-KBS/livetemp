/**
 * Bindings voor onze `hat` library
 */
namespace WideWorldImporters.LiveTemp.Impl.Internal {

    /**
     * Directe mapping voor exported funcs uit sensor.h <br />
     *
     * Om een of andere reden pakt de linker de defined alias niet, dus gebruik de internal functie naam.
     * (dit kan misschien omdat hij nooit opgeroepen wordt!?)
     */
    namespace Sensor {

        /**
         * Lees de temperatuur van de Sense Hat.
         *
         * @return double
         */
        [CCode (cname = "_lt_sensor_temp_read")]
        private extern double temp_read();

    }

}