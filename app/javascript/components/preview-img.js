if (window.location.pathname == '../../views/collages/edit') {
  // Select image uploader and image preview div
  const imgPreview = document.querySelector('.collage-card-img');
  const imgUploader = document.querySelector('#image-upload');

  // Event triggered when the file is changed
  imgUploader.addEventListener('change', (event) => {
    console.log(event.target);

    const input = event.target;
    // Create new object 'filereader' (built-in JS) - reads contents of files that are stored on the user's computer
    const reader = new FileReader();
    reader.onload = () => {
      // reader.results gives us a data-URL that can be used to preview the image
      imgPreview.innerHTML = `<img src=${reader.result}>`;
    };
    reader.readAsDataURL(input.files[0]);
  });
};
// Resources:
// https://www.javascripture.com/FileReader#readAsDataURL
// https://developer.mozilla.org/en-US/docs/Web/API/FileReader