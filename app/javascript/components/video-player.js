const initMixtape = () => {

  const mixtapeYoutubePlayerEl = document.querySelector(
    ".js-mixtape-youtube-player"
  );
  console.log("hello");

  if (mixtapeYoutubePlayerEl) {
    const videoControlsEl = mixtapeYoutubePlayerEl.querySelector(
      ".js-video-controls"
    );
    const playPauseBtnEl = videoControlsEl.querySelector(".js-play-pause");

    const pauseBtnEl = videoControlsEl.querySelector(".js-pause");

    const videos = JSON.parse(mixtapeYoutubePlayerEl.dataset.playlistVideos);

    const getVideoIdFromYoutubeUrl = (youtubeUrl) =>
      youtubeUrl.replace("https://www.youtube.com/watch?v=", "");

    const init = () => {
      // 2. This code loads the IFrame Player API code asynchronously.
      const tag = document.createElement("script");

      tag.src = "https://www.youtube.com/iframe_api";
      const firstScriptTag = document.getElementsByTagName("script")[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    };

    let player;

    let currentTrack = 0;

    window.onYouTubeIframeAPIReady = function () {
      player = new window.YT.Player("player", {
        // height + width = 0 to hide video
        height: "0",
        width: "0",
        videoId: getVideoIdFromYoutubeUrl(videos[currentTrack].url),
        playerVars: {
          start: videos[currentTrack].start,
          end: videos[currentTrack].end
        },
        events: {
          onReady: onPlayerReady,
          onStateChange: onPlayerStateChange
        }
      });
    };

    let currentVideoState = -1;

    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
      const youtubePlayer = event.target;

      playPauseBtnEl.addEventListener("click", function () {
        if (
          currentVideoState === YT.PlayerState.PAUSED ||
          currentVideoState === YT.PlayerState.UNSTARTED
        ) {
          youtubePlayer.playVideo();
        }
      });

      pauseBtnEl.addEventListener("click", function () {
        if (currentVideoState === YT.PlayerState.PLAYING) {
          youtubePlayer.pauseVideo();
        }
      });
    }

    let preventDuplicateSkip = false;

    function onPlayerStateChange(event) {
      if (event.data === YT.PlayerState.ENDED && !preventDuplicateSkip) {
        currentTrack++;
        if (videos[currentTrack]) {
          player.loadVideoById({
            videoId: getVideoIdFromYoutubeUrl(videos[currentTrack].url),
            startSeconds: videos[currentTrack].start,
            endSeconds: videos[currentTrack].end
          });
          preventDuplicateSkip = true;
          setTimeout(function () {
            preventDuplicateSkip = false;
          }, 500);
        }
      } else {
        currentVideoState = event.data;
        // playPauseBtnEl.innerHTML =
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
