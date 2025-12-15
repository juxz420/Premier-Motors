// Google Maps API Configuration
const GOOGLE_CONFIG = {
    // Wklej tutaj swój klucz API Google Maps
    // Uzyskaj go na: https://console.cloud.google.com/
    apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
    
    // Place ID Twojej firmy
    // Znajdź go używając: https://developers.google.com/maps/documentation/javascript/examples/places-placeid-finder
    placeId: 'YOUR_PLACE_ID',
    
    // Ustawienia wyświetlania
    maxReviews: 6,           // Maksymalna liczba opinii do wyświetlenia
    minRating: 4,            // Minimalna ocena do wyświetlenia (1-5)
    sortBy: 'most_relevant', // 'most_relevant' lub 'newest'
    language: 'pl'           // Język opinii
};
