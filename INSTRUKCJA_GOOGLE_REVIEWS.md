# Instrukcja konfiguracji Google Reviews

## Krok 1: Uzyskaj klucz API Google Maps

1. Wejdź na [Google Cloud Console](https://console.cloud.google.com/)
2. Zaloguj się kontem Google
3. Utwórz nowy projekt lub wybierz istniejący
4. Włącz **Places API**:
   - Menu → APIs & Services → Library
   - Wyszukaj "Places API"
   - Kliknij "Enable"
5. Utwórz klucz API:
   - Menu → APIs & Services → Credentials
   - Kliknij "Create Credentials" → "API Key"
   - Skopiuj wygenerowany klucz
6. **Ważne - zabezpiecz klucz**:
   - Kliknij na nazwę klucza
   - W sekcji "Application restrictions" wybierz "HTTP referrers"
   - Dodaj: `https://twoja-domena.pl/*` (zastąp swoją domeną)
   - W sekcji "API restrictions" wybierz "Restrict key"
   - Zaznacz tylko "Places API"
   - Zapisz

## Krok 2: Znajdź Place ID Twojej firmy

### Metoda A - Używając narzędzia Google:
1. Wejdź na [Place ID Finder](https://developers.google.com/maps/documentation/javascript/examples/places-placeid-finder)
2. Wpisz nazwę i adres swojej firmy
3. Kliknij na znacznik na mapie
4. Skopiuj "Place ID" (format: `ChIJ...`)

### Metoda B - Używając linku Google Maps:
1. Znajdź swoją firmę na Google Maps
2. Skopiuj URL (np. `https://www.google.com/maps/place/...`)
3. Użyj narzędzia online do ekstrakcji Place ID z URL

### Metoda C - Programatycznie:
```javascript
// Możesz użyć tego kodu w konsoli przeglądarki na stronie Google Maps
// z otwartą kartą Twojej firmy
const url = window.location.href;
const match = url.match(/!1s([^!]+)/);
if (match) console.log('Place ID:', match[1]);
```

## Krok 3: Skonfiguruj config.js

Otwórz plik `config.js` i wklej swoje dane:

```javascript
const GOOGLE_CONFIG = {
    apiKey: 'AIzaSy...twój-klucz-tutaj',     // Klucz z kroku 1
    placeId: 'ChIJ...twój-place-id',         // Place ID z kroku 2
    
    // Opcjonalne ustawienia:
    maxReviews: 6,           // Ile opinii wyświetlać (max)
    minRating: 4,            // Minimalna ocena (1-5)
    sortBy: 'most_relevant', // 'most_relevant' lub 'newest'
    language: 'pl'           // Język
};
```

## Krok 4: Przetestuj

1. Otwórz `premier.html` w przeglądarce
2. Przewiń do sekcji "Opinie Naszych Klientów"
3. Sprawdź konsolę (F12) czy nie ma błędów
4. Opinie powinny się automatycznie załadować z Google

## Rozwiązywanie problemów

### "Brak klucza API Google Maps"
- Sprawdź czy wkleiłeś klucz w `config.js`
- Klucz nie może być pusty ani "YOUR_GOOGLE_MAPS_API_KEY"

### "Brak Place ID"
- Sprawdź czy wkleiłeś Place ID w `config.js`
- Place ID powinien zaczynać się od "ChIJ"

### "This API project is not authorized to use this API"
- Upewnij się, że włączyłeś **Places API** w Google Cloud Console
- Zaczekaj 5-10 minut na propagację zmian

### "This IP, site or mobile application is not authorized"
- Dodaj swoją domenę do HTTP referrers w ustawieniach klucza API
- Dla testów lokalnych dodaj: `http://localhost/*`

### "You have exceeded your request quota"
- Google Places API ma limit darmowych zapytań (bezpłatnie: pierwsze $200/miesiąc)
- Ustaw limit budżetu w Google Cloud Console

### Opinie się nie wyświetlają
- Sprawdź czy Twoja firma ma opinie na Google
- Sprawdź ustawienie `minRating` - może być za wysokie
- Otwórz konsolę (F12) i sprawdź błędy

## Ustawienia zaawansowane

### Zmiana liczby wyświetlanych opinii:
```javascript
maxReviews: 10,  // Zmień na 10, 20 etc.
```

### Wyświetlaj tylko najnowsze opinie:
```javascript
sortBy: 'newest',  // Zamiast 'most_relevant'
```

### Wyświetlaj wszystkie opinie (nawet słabe):
```javascript
minRating: 1,  // Zamiast 4
```

### Zmień język:
```javascript
language: 'en',  // 'pl', 'en', 'de', etc.
```

## Koszty

Google Places API jest **płatne**, ale oferuje:
- **$200 darmowych kredytów miesięcznie** (odnawialnych)
- Po przekroczeniu: ~$17 za 1000 zapytań

Dla większości małych firm darmowy limit wystarczy!

## Bezpieczeństwo

✅ **Zalecane**:
- Ogranicz klucz API do swojej domeny (HTTP referrers)
- Ogranicz do tylko Places API
- Monitoruj użycie w Google Cloud Console

❌ **Nie rób tego**:
- Nie udostępniaj klucza publicznie (np. GitHub)
- Nie używaj tego samego klucza do wielu projektów
- Nie zostawiaj klucza bez ograniczeń

## Automatyczne odświeżanie

Opinie automatycznie odświeżają się przy każdym odwiedzeniu strony. Google cache'uje dane, więc nowe opinie mogą pojawić się z opóźnieniem ~24h.

Jeśli chcesz ręczne odświeżanie, możesz dodać przycisk który wywołuje `loadGoogleReviews()`.

---

**Potrzebujesz pomocy?** Sprawdź:
- [Google Places API Documentation](https://developers.google.com/maps/documentation/places/web-service/overview)
- [Google Cloud Console](https://console.cloud.google.com/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/google-places-api)
