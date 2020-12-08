const initMixtape = () => {

  $('.modal').on('shown.bs.modal', function () {
    $('input:text:visible:first', this).focus();
  });

  const mixtapeYoutubePlayerEl = document.querySelector(
    ".js-mixtape-youtube-player"
  );
  console.log("hello");

  if (mixtapeYoutubePlayerEl) {
    const videoControlsEl = mixtapeYoutubePlayerEl.querySelector(
      ".js-video-controls"
    );
    const playBtnEl = videoControlsEl.querySelector(".js-play-pause");

    const pauseBtnEl = videoControlsEl.querySelector(".js-pause");

    const fastforwardBtnEl = videoControlsEl.querySelector(".js-fast-forward");

    const rewindBtnEl = videoControlsEl.querySelector(".js-rewind");

    const videos = JSON.parse(mixtapeYoutubePlayerEl.dataset.playlistVideos);

    const getVideoIdFromYoutubeUrl = (youtubeUrl) =>
      youtubeUrl.replace("https://youtu.be/", "");

    const init = () => {
      // 2. This code loads the IFrame Player API code asynchronously.
      const tag = document.createElement("script");

      tag.src = "https://www.youtube.com/iframe_api";
      const firstScriptTag = document.getElementsByTagName("script")[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    };

    const players = []

    let currentTrack = 0;

    window.onYouTubeIframeAPIReady = function () {
      const videoDivHolder = mixtapeYoutubePlayerEl.querySelector("#player");
      videos.forEach (function(video) {
        console.log(video)
        const videoDiv = document.createElement("div");
        videoDivHolder.appendChild(videoDiv)
        players.push (new window.YT.Player(videoDiv, {
          // height + width = 0 to hide video
          height: "500",
          width: "400",
          videoId: getVideoIdFromYoutubeUrl(video.url),
          playerVars: {
            start: video.start,
            end: video.end
          },
          events: {
            // onReady: onPlayerReady,
            onStateChange: onPlayerStateChange
          }
        }));
      });
      console.log(players)
    };

    let currentVideoState = -1;

    // 4. The API will call this function when the video player is ready.
    // function onPlayerReady(event) {
    //   const youtubePlayer = event.target;

      playBtnEl.addEventListener("click", function () {
          players[currentTrack].playVideo();
      });

      pauseBtnEl.addEventListener("click", function () {
          players[currentTrack].pauseVideo();
      });

    // }

    let preventDuplicateSkip = false;

    function onPlayerStateChange(event) {
      if (event.data === YT.PlayerState.ENDED && !preventDuplicateSkip) {
        currentTrack++;
        if (videos[currentTrack]) {
          players[currentTrack].playVideo();
          // preventDuplicateSkip = true;
          // setTimeout(function () {
          //   preventDuplicateSkip = false;
          // }, 500);
        }
      } else {
        currentVideoState = event.data;
        // playBtnEl.innerHTML =
        //   event.data === YT.PlayerState.UNSTARTED ||
        //   event.data === YT.PlayerState.PAUSED
        //     ? "Play ▶️"
        //     : "Pause ⏸";
      }
    }

    init();
  }
}


export { initMixtape };



