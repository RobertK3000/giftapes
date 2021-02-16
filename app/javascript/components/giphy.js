// Only execute script on collage#edit page
const regexp = /\/collages\/\d*\/edit/;

if (regexp.test(window.location.pathname)) {
  // Declare API key, limit results, display div
  const apiKey = 'ukEUx9VYjh53bWi5SU4EVbS8vJbbL5qJ';
  const limitResults = 30;
  const resultsDiv = document.querySelector('#giphy-results');

  // Variables for eventListener
  const gifForm = document.querySelector('#giphy-submit');
  const gifTrending = document.querySelector('#giphy-trending');
  const gifRandom = document.querySelector('#giphy-random');
  const collageCard = document.querySelector('#collage-card-img');

  // FUNCTIONS
  // Preview selected GIF on click
  const giphyClick = (gif, url) => {
    // Listen for click action on gif, then insert into collage card
    gif.addEventListener('click', () => {
      // Had to use HTML5 video version of the link? All the other wouldn't work :(
      collageCard.innerHTML = `<img src=${url}>`
    });
  };
  // Fetch JSON data from URL, display results in HTML
  const giphyParse = (url) => {
    fetch(url)
    .then(response => response.json())
    .then(content => {
      // Convert returned URL to display as image
      content.data.forEach(gifResult => {
        // Build image element from returned data points, then insert into results div on HTML page
        let img = `<img \
          src=${gifResult.images.fixed_height_small.url} \
          alt="${gifResult.title}">`;

        resultsDiv.insertAdjacentHTML('beforeend', img);
        // Add event listener to GIF that was just inserted
        const lastGif = document.querySelector('#giphy-results').lastChild;
        giphyClick(lastGif, gifResult.images.original.url);
      });
    });
  };
  // GIPHY gif-search function
  const giphySearch = () => {
    // Grab search query from HTML and build URL;
    const query = document.querySelector('#giphy-search').value;
    const url = `https://api.giphy.com/v1/gifs/search?api_key=${apiKey}&q=${query}&limit=${limitResults}&lang=en`;
    // Clear previous results, parse results
    resultsDiv.innerHTML = '';
    giphyParse(url);
  };
  // GIPHY trending function
  const giphyTrends = () => {
    const url = `https://api.giphy.com/v1/gifs/trending?api_key=${apiKey}&limit=${limitResults}&lang=en`;
    // Clear previous results
    resultsDiv.innerHTML = '';
    giphyParse(url);
  };
  // GIPHY random function
  const giphyRandom = () => {
    const url = `https://api.giphy.com/v1/gifs/random?api_key=${apiKey}`;
    resultsDiv.innerHTML = '';
    fetch(url)
    .then(response => response.json())
    .then(content => {
      collageCard.innerHTML = `<img src="${content.data.image_url}">`;
    });
  };

  // EVENT LISTENERS
  // Find GIFs with search query
  gifForm.addEventListener('click', (event) => {
    event.preventDefault();
    giphySearch();
  });
  // Find trending GIFs
  gifTrending.addEventListener('click', (event) => {
    event.preventDefault();
    giphyTrends();
  });
  // Generate random GIF
  gifRandom.addEventListener('click', (event) => {
    event.preventDefault();
    giphyRandom();
  });
  // Generate unique user-id for signed-in user??
};