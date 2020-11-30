require(httr)
require(rjson)
require(stringr)

hentEnhet <- function(orgNr) {
  
  ##INTERN HJELPEFUNKSJON
  x <- function(data) {
    enhet <- fromJSON(data)
    
    # Hvis org finnes, returnér den som liste
    if ("organisasjonsnummer" %in% names(enhet)) {
      enhet <- fromJSON(data)
      enhet$underenhet <- "overordnetEnhet" %in% names(enhet$"links")
      return(enhet)
      
      # hvis api returnerer en feilmelding, print feilmelding og returner NULL  
    } else if ("valideringsfeil" %in% names(enhet)) {
      print(enhet$valideringsfeil[[1]]$feilmelding)
      return(NULL)
      
      # hvis noe annet skjer er det veldig mystisk
    } else {
      print("Ukjent feil. Vennligst meld fra på github.com/haavaros/enhetsregisteret/issues")
      return(NULL)
    }
  }

  ## HOVEDFUNKSJON
  # rense input
  nr <- as.character(orgNr)
  nr <- gsub("[[:space:]]", "", nr)
  
  ## HENTE DATA
  enhet_url <- paste('https://data.brreg.no/enhetsregisteret/api/enheter', nr, sep = "/")
  underenhet_url <- paste('https://data.brreg.no/enhetsregisteret/api/underenheter', nr, sep = "/")
  enhet_streng <- content(GET(enhet_url), 'text', encoding = "UTF-8")
  underenhet_streng <- content(GET(underenhet_url), 'text', encoding = "UTF-8")
  
  # Hvis enheten ikke eksisterer, returnerer brreg en tom streng. 
  # Sjekker først begge registre (enhet og underenhet)
  # Hvis begge er tomme, printes feilmelding og NULL returneres
  if (nchar(enhet_streng) > 0) {
    enhet <- x(enhet_streng)
    return(enhet)
    
  } else if (nchar(underenhet_streng) > 0) {
    underenhet <- x(underenhet_streng)
    return(underenhet)
    
  } else {
    print("Ingen organisasjon har dette nummeret.")
    return(NULL)
  }
}

