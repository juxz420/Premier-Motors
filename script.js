(function () {
  const offersUrl = 'offers.json';

  async function fetchOffers() {
    
    if (location.protocol === 'file:') {
      try {
        const inline = document.getElementById('offers-data');
        if (inline) return JSON.parse(inline.textContent);
      } catch (err) {
        console.error('Failed to parse inline offers data:', err);
        return [];
      }
    }

    try {
      const res = await fetch(offersUrl, {cache: 'no-store'});
      if (res.ok) return await res.json();
      console.warn('Fetch offers returned non-ok status:', res.status);
    } catch (err) {
      console.warn('Fetch offers failed. Falling back to inline data. Error:', err && err.message);
    }

    try {
      const inline = document.getElementById('offers-data');
      if (inline) return JSON.parse(inline.textContent);
    } catch (err) {
      console.error('Failed to parse inline offers data:', err);
    }

    return [];
  }

  function createOfferCard(offer) {
    const article = document.createElement('article');
    article.className = 'offer-card';

    const link = document.createElement('a');
    link.href = offer.url || '#';
    link.target = '_blank';
    link.rel = 'noopener';

    const img = document.createElement('img');
    img.src = offer.image || '';
    img.alt = offer.title || '';

    const body = document.createElement('div');
    body.className = 'offer-body';

    const h3 = document.createElement('h3');
    h3.textContent = offer.title || 'Brak tytułu';

    const p = document.createElement('p');
    p.className = 'price';
    p.textContent = offer.price || '';

    body.appendChild(h3);
    body.appendChild(p);
    link.appendChild(img);
    link.appendChild(body);
    article.appendChild(link);

    return article;
  }

  function renderPreview(offers, limit = 3) {
    const container = document.querySelector('.offers-preview .offers-grid');
    if (!container) return;
    container.innerHTML = '';
    offers.slice(0, limit).forEach(o => container.appendChild(createOfferCard(o)));
  }

  function renderFullList(offers) {
    const container = document.querySelector('.offers-section .offers-grid');
    if (!container) return;
    container.innerHTML = '';
    offers.forEach(o => container.appendChild(createOfferCard(o)));
  }

  document.addEventListener('DOMContentLoaded', async () => {
    const offers = await fetchOffers();
    renderPreview(offers, 3);
    renderFullList(offers);
  });
})();
