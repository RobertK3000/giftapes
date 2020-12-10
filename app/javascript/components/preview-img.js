// Only execute script on collages#edit page
const regexp = /\/collages\/\d*\/edit/;
if (regexp.test(window.location.pathname) === true ) {
  console.log("hello");
  const addCard = document.querySelector('#collage-modal-btn');
  addCard.addEventListener('click', () => {
    // Select image uploader and image preview div
    const imgPreview = document.querySelector('#collage-card-img');
    const imgUploader = document.querySelector('#collage_item_photo');

    // Event triggered when the file is changed
    imgUploader.addEventListener('change', (event) => {

      const input = event.target;
      // Create new object 'filereader' (built-in JS) - reads contents of files that are stored on the user's computer
      const reader = new FileReader();
      reader.onload = () => {
        // reader.results gives us a data-URL that can be used to preview the image
        imgPreview.innerHTML = `<img src=${reader.result}>`;
      };
      reader.readAsDataURL(input.files[0]);
    });
  });
};
