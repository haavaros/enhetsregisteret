# Hent informasjon om enhet via Enhetsregisterets API

## Norsk

Kopier dette skriptet til din maskin og skriv inn i din egen kode: 

    source(<bane til enhetregisteret.R>)

Deretter kan du kalle `hentEnhet(organisasjonsnummer)` i din egen kode. Funksjonen returnerer en navngitt liste for enheten med det oppgitte organisasjonsnummeret. Dersom det er en feil i organisasjonsummeret, eller det ikke finnes noen enhet med organisasjonsnummeret, returneres et NULL-objekt.

## English
This function retrieves information from the Norwegian registry of legal entities. The function returns a named list for the given entity registration number if the registration number is valid.

