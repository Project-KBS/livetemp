using Soup;

/**
 * Utility class met netwerk operations.
 */
public class WideWorldImporters.LiveTemp.Netwerk {

    /**
     * Een collectie van alle cookies welke we versturen met elke HTTP request. <br />
     *
     * Hieraan wordt standaard een cookie met `client-type` toegevoegd.
     */
    private static SList<Cookie> COOKIES = new SList<Cookie>();

    static construct {
        COOKIES.append(new Cookie("client-type", "wwi-live-temp", "localhost", "/", -1));
    }

    /**
     * Verstuur een HTTP-POST naar `url`. <br />
     *
     * Het resultaat wat de server terugstuurt wordt niet opgeslagen.
     *
     * @param url      string De destination URL
     * @param contents string De form-encoded key-value gegevens (bijv. `temp=3.2&limit=1&x=2`).
     */
    public static void post(string url, string contents) {

        Soup.MemoryUse buffer  = Soup.MemoryUse.STATIC;
        Session        session = new Session();
        Message        message = new Message("POST", url);

        message.set_request("application/x-www-form-urlencoded", buffer, contents.data);
        Soup.cookies_to_request(COOKIES, message);

        session.send_message(message);

    }

    /**
     * Verstuur een HTTP-GET naar `url`. <br />
     *
     * Het antwoord wat de server terugstuurt wordt opgeslagen naar een string en gereturned.
     *
     * @param url      string De destination URL
     * @return         string Het antwoord van de server
     */
    public static string get(string url) {

        Session        session = new Session();
        Message        message = new Message("GET", url);

        Soup.cookies_to_request(COOKIES, message);

        session.send_message(message);

        return (string) message.response_body.data;

    }

}