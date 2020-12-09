const initMixtape = () => {

  $('.modal').on('shown.bs.modal', function () {
    $('input:text:visible:first', this).focus();
  });

  const mixtapeYoutubePlayerEl = document.querySelector(
    ".js-mixtape-youtube-player"
  );

  const reelScenes = document.querySelectorAll(".cyl-2 ")
  console.log(reelScenes)

  if (mixtapeYoutubePlayerEl) {
    const videoControlsEl = mixtapeYoutubePlayerEl.querySelector(
      ".js-video-controls"
    );

    const playerStates = { "-1": false, "0": false, "1": true, "2": false, "3": true, "4": false, "5": false }

    const isPlaying = () => {
      return playerStates[players[currentTrack].getPlayerState()]
    }

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
          height: "200",
          width: "150",
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

      playBtnEl.addEventListener("click", function () {
          reelScenes[0].classList.remove("pause")
          reelScenes[1].classList.remove("pause")
          reelScenes[0].classList.add("play-forward")
          reelScenes[1].classList.add("play-forward")
    });

    //   playBtnEl.addEventListener("click", function () {
    //     for (let i = 0; i < reelScenesEl.length; i++) {
    //       reelScenesEl[i].style.animation-duration = 4s;
    //     }
    // });      

      pauseBtnEl.addEventListener("click", function () {
          players[currentTrack].pauseVideo();
      });

      pauseBtnEl.addEventListener("click", function () {
          reelScenes[0].classList.remove("play-forward")
          reelScenes[1].classList.remove("play-forward")
          reelScenes[0].classList.add("pause")
          reelScenes[1].classList.add("pause")
    });


      let fastSeekTimer = null
      let currentTime = 0
      let isPlayingBeforeSeek = false

      fastforwardBtnEl.addEventListener("mousedown", function () {
          isPlayingBeforeSeek = isPlaying();
          players[currentTrack].pauseVideo();
          currentTime = players[currentTrack].getCurrentTime();
          fastSeekTimer = setInterval(function() {
            // adjust speed of fast-forward/rewind below 
            currentTime += 2;
            if (currentTime > endTimes[currentTrack]) {
              currentTrack += 1;
              currentTime = videos[currentTrack].start || 0;
            }
            console.log(currentTime, 'currentTime');
            console.log(currentTrack, 'currentTrack');
          }, 250);
      });

// const playerStates = { "-1": false, "0": false, "1": true, "2": false, "3": true, "4": false, "5": false }

      fastforwardBtnEl.addEventListener("mouseup", function () {
        clearTimeout(fastSeekTimer)
        players[currentTrack].seekTo(currentTime, true)
        console.log(isPlayingBeforeSeek)
        console.log(players[currentTrack].getPlayerState())
        if (isPlayingBeforeSeek) {
          players[currentTrack].playVideo();
        } else {
          players[currentTrack].pauseVideo();
        }
      });

      fastforwardBtnEl.addEventListener("mousedown", function () {
          reelScenes[0].classList.add("fast-forward")
          reelScenes[1].classList.add("fast-forward")
      });

      fastforwardBtnEl.addEventListener("mouseup", function () {
          reelScenes[0].classList.remove("fast-forward")
          reelScenes[1].classList.remove("fast-forward")
    });

      rewindBtnEl.addEventListener("mousedown", function () {
        isPlayingBeforeSeek = isPlaying();
        players[currentTrack].pauseVideo();
        currentTime = players[currentTrack].getCurrentTime();
        fastSeekTimer = setInterval(function() { 
          // adjust speed of fast-forward/rewind below
          currentTime -= 2;
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
        console.log(isPlayingBeforeSeek)
        console.log(players[currentTrack].getPlayerState())
        if (isPlayingBeforeSeek) {
          players[currentTrack].playVideo();
        } else {
          players[currentTrack].pauseVideo();
        }
      });

      rewindBtnEl.addEventListener("mousedown", function () {
        reelScenes[0].classList.add("reverse")
        reelScenes[1].classList.add("reverse")
    });

      rewindBtnEl.addEventListener("mouseup", function () {
        reelScenes[0].classList.remove("reverse")
        reelScenes[1].classList.remove("reverse")
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



