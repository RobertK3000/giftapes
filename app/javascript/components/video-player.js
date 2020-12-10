const initMixtape = () => {

  $('.modal').on('shown.bs.modal', function () {
    $('input:text:visible:first', this).focus();
  });

  const mixtapeYoutubePlayerEl = document.querySelector(
    ".js-mixtape-youtube-player"
  );

  var playSoundEffect = new Audio("https://res.cloudinary.com/susanjsp/video/upload/v1607491915/play.mp3");

  var pauseSoundEffect = new Audio("https://res.cloudinary.com/susanjsp/video/upload/v1607491915/pause.mp3");

  var fastForwardRewindSoundEffect = new Audio("https://res.cloudinary.com/susanjsp/video/upload/v1607491924/fast_forward_rewind.mp3");

  const reelScenes = document.querySelectorAll(".cyl-2 ")
  console.log(reelScenes)

  const musicalNotes = document.querySelectorAll(".musicalnotes")

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
          height: "0",
          width: "0",
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
        playSoundEffect.play();
      });

      playBtnEl.addEventListener("click", function () {
        musicalNotes[0].innerHTML="&#9835;";
        musicalNotes[1].innerHTML="&#9833;";
        musicalNotes[2].innerHTML="&#9839;";
        musicalNotes[3].innerHTML="&#9834;";
      });


      playBtnEl.addEventListener("click", function () {
          reelScenes[0].classList.remove("pause")
          reelScenes[1].classList.remove("pause")
          reelScenes[0].classList.add("play-forward")
          reelScenes[1].classList.add("play-forward")
    });

      pauseBtnEl.addEventListener("click", function () {
          players[currentTrack].pauseVideo();
      });

      pauseBtnEl.addEventListener("click", function () {
        musicalNotes[0].innerHTML="";
        musicalNotes[1].innerHTML="";
        musicalNotes[2].innerHTML="";
        musicalNotes[3].innerHTML="";
      });


      pauseBtnEl.addEventListener("click", function () {
        pauseSoundEffect.play();
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
            currentTime += 4;
            if (currentTime > endTimes[currentTrack]) {
              currentTrack += 1;
              currentTime = videos[currentTrack].start || 0;
            }
            console.log(currentTime, 'currentTime');
            console.log(endTimes[currentTrack], 'endTimes[currentTrack]');
            console.log(currentTrack, 'currentTrack');
            console.log(players.length - 1, 'lastTrack');
            console.log(players.[currentTrack], 'players[CurrentTrack]');
          }, 250);
      });

// const playerStates = { "-1": false, "0": false, "1": true, "2": false, "3": true, "4": false, "5": false }

      fastforwardBtnEl.addEventListener("mouseup", function () {
        clearTimeout(fastSeekTimer)
        players[currentTrack].seekTo(currentTime, true)
        // console.log(isPlayingBeforeSeek)
        // console.log(players[currentTrack].getPlayerState())
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

      fastforwardBtnEl.addEventListener("mousedown", function () {
          fastForwardRewindSoundEffect.currentTime = 0;
          fastForwardRewindSoundEffect.play();
      });

      fastforwardBtnEl.addEventListener("mouseup", function () {
          reelScenes[0].classList.remove("fast-forward")
          reelScenes[1].classList.remove("fast-forward")
      });

      fastforwardBtnEl.addEventListener("mouseup", function () {
          fastForwardRewindSoundEffect.pause();
      });

      rewindBtnEl.addEventListener("mousedown", function () {
        isPlayingBeforeSeek = isPlaying();
        players[currentTrack].pauseVideo();
        currentTime = players[currentTrack].getCurrentTime();
        fastSeekTimer = setInterval(function() { 
          // adjust speed of fast-forward/rewind below
          currentTime -= 4;
          if ((currentTime < videos[currentTrack].start && currentTrack !== 0) || 0) {
            currentTrack -= 1;
            currentTime = videos[currentTrack].end || endTimes[currentTrack];
          }
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

      rewindBtnEl.addEventListener("mousedown", function () {
        fastForwardRewindSoundEffect.currentTime = 0;
        fastForwardRewindSoundEffect.play();
    });

      rewindBtnEl.addEventListener("mouseup", function () {
        reelScenes[0].classList.remove("reverse")
        reelScenes[1].classList.remove("reverse")
    });

      rewindBtnEl.addEventListener("mouseup", function () {
        fastForwardRewindSoundEffect.pause();
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



