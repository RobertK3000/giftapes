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

    const players = [];
    const endTimes = [];

    let currentTrack = 0;

    window.onYouTubeIframeAPIReady = function () {
      const videoDivHolder = mixtapeYoutubePlayerEl.querySelector("#player");
      videos.forEach (function(video, index) {
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
            onReady: function(event) {
              // If video start and end exist, use the difference between them for the duration otherwise ask Youtube how long the video is.
              // let thisVideosDuration = event.target.getDuration();
              // if (video.end && !video.start) {
              //   thisVideosDuration = video.end ;
              // }
              // else if (video.start && video.end) {
              //   thisVideosDuration = video.end - video.start;
              // }
              // else if (video.start && !video.end) {
              //   thisVideosDuration = event.target.getDuration() - video.start;
              // }
        
              endTimes[index] = video.end || event.target.getDuration();
            },
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

      let fastSeekTimer = null
      let currentTime = 0

      fastforwardBtnEl.addEventListener("mousedown", function () {
          players[currentTrack].pauseVideo();
          currentTime = players[currentTrack].getCurrentTime();
          fastSeekTimer = setInterval(function() { 
            currentTime += 1;
            if (currentTime > endTimes[currentTrack]) {
              currentTrack += 1;
              currentTime = videos[currentTrack].start || 0;
            }
            console.log(currentTime, 'currentTime');
            console.log(currentTrack, 'currentTrack');
          }, 250);
      });

      fastforwardBtnEl.addEventListener("mouseup", function () {
        clearTimeout(fastSeekTimer)
        players[currentTrack].seekTo(currentTime, true)
        players[currentTrack].playVideo();
      });

      rewindBtnEl.addEventListener("mousedown", function () {
        players[currentTrack].pauseVideo();
        currentTime = players[currentTrack].getCurrentTime();
        fastSeekTimer = setInterval(function() { 
          currentTime -= 1;
          if (currentTime < videos[currentTrack].start || 0) {
            currentTrack -= 1;
            currentTime = videos[currentTrack].end || endTimes[currentTrack];
          }
          console.log(currentTime, 'currentTime');
          console.log(currentTrack, 'currentTrack');
        }, 250);
      });

      rewindBtnEl.addEventListener("mouseup", function () {
        clearTimeout(fastSeekTimer)
        players[currentTrack].seekTo(currentTime, true)
        players[currentTrack].playVideo();
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



