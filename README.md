# Wide World Importers real-time temperatuur aflezer.

Deze applicatie leest de temperatuur van een product af en verstuurt de data naar een server met de CMS software er op.
Het is de bedoeling dat deze app op een Raspberry Pi gedraaid wordt. Voor het gemak heb ik een docker container gemaakt.

De interactie met de RPi Sense Hat is in C geschreven (zie de `hat` folder) en om memory leaks te voorkomen is de
netwerk code in de Vala taal geschreven. Deze programmeertaal is een mix van Java en Csharp welke direct met C libraries
gegevens kan uitwisselen.