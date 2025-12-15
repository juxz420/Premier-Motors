# Premier Motors

🚗 Profesjonalna strona dla firmy zajmującej się importem, rejestracją i sprzedażą samochodów i motocykli premium.

## 🌟 Funkcje

- ✅ **Responsywny design** - działa na wszystkich urządzeniach
- ✅ **PWA** (Progressive Web App) - możliwość instalacji jak aplikacja
- ✅ **Google Reviews** - automatyczne pobieranie opinii z Google Maps API
- ✅ **Panel administracyjny** - zarządzanie wyświetlanymi opiniami
- ✅ **Zaawansowane filtry** - po typie, marce, roku, cenie, statusie, formie sprzedaży
- ✅ **Touch gestures** - swipe, pinch-to-zoom, double-tap w galeriach
- ✅ **Lazy loading** - optymalizacja ładowania obrazów i wideo
- ✅ **SEO optimized** - meta tagi, Open Graph, Twitter Cards
- ✅ **Offline support** - Service Worker z cache

## 📂 Struktura projektu

```
Premier Motors/
├── premier.html           # Strona główna
├── oferty.html           # Aktualne oferty z filtrami
├── realizacje.html       # Zrealizowane sprzedaże
├── admin.html            # Panel zarządzania opiniami
├── style.css             # Główny arkusz stylów (1417 linii)
├── script.js             # Główna logika JavaScript
├── config.js             # Konfiguracja Google Maps API
├── service-worker.js     # PWA Service Worker
├── manifest.json         # PWA Manifest
├── reviews-data.json     # Dane opinii klientów
├── offers.json           # Dane ofert
└── images/              # Katalog ze zdjęciami
```

## 🚀 Uruchomienie lokalnie

1. Sklonuj repozytorium:
```bash
git clone https://github.com/TWOJA-NAZWA/premier-motors.git
cd premier-motors
```

2. Uruchom lokalny serwer:
```bash
python -m http.server 8000
```

3. Otwórz w przeglądarce:
```
http://localhost:8000/premier.html
```

## 🔧 Konfiguracja Google Reviews

1. Uzyskaj klucz API Google Maps (szczegóły w `INSTRUKCJA_GOOGLE_REVIEWS.md`)
2. Znajdź Place ID swojej firmy
3. Edytuj `config.js`:
```javascript
const GOOGLE_CONFIG = {
    apiKey: 'TWOJ-KLUCZ-API',
    placeId: 'TWOJ-PLACE-ID',
    maxReviews: 6,
    minRating: 4,
    sortBy: 'most_relevant',
    language: 'pl'
};
```

## 🛠️ Technologie

- **HTML5** - semantyczny markup
- **CSS3** - nowoczesne stylowanie, animacje, grid, flexbox
- **Vanilla JavaScript** - bez frameworków, czysty ES6+
- **PWA** - Progressive Web App z Service Worker
- **Google Maps API** - dynamiczne pobieranie opinii

## 📱 Funkcje mobilne

- Touch gestures (swipe, pinch-to-zoom)
- Hamburger menu
- Responsywne karuzele
- Click-to-call, click-to-email
- Optymalizacja dla iOS Safari

## 🎨 Design

- Elegancki design czarno-biały z akcentami czerwieni
- Typografia: Perpetua, Playfair Display, Lato
- Płynne animacje i przejścia
- Scroll reveal effects
- GPU-accelerated animations

## 📈 SEO & Performance

- Meta tagi (Open Graph, Twitter Cards)
- Lazy loading obrazów i wideo
- Service Worker caching
- Minified & optimized assets
- Breadcrumbs navigation
- Semantic HTML

## 👨‍💼 Panel administracyjny

Dostęp: `admin.html`

- Zarządzanie wyświetlanymi opiniami (widoczność)
- Dodawanie nowych opinii
- Usuwanie opinii
- Edycja podsumowania (rating, liczba opinii)
- Export do JSON

## 📄 Licencja

© 2025 Premier Motors. Wszelkie prawa zastrzeżone.

## 🤝 Kontakt

- Email: info@premiermotors.pl
- Telefon: +48 XXX XXX XXX

---

**Live Demo:** [https://TWOJA-NAZWA.github.io/premier-motors/](https://TWOJA-NAZWA.github.io/premier-motors/)
