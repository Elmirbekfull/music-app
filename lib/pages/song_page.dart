import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // конвертировать продолжительность в минуты: секунды
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      // get playlist
      final playlist = value.playlist;
      // get current index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      // return UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    // title
                    const Text("АУДИОЛИСТ"),
                    // menu button
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.music_note)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // album at work
                NeuBox(
                  child: Column(
                    children: [
                      // image
                      SizedBox(
                        height: 350,
                        width: 600,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            currentSong.albumArtImagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // song and artist name and icon
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(currentSong.artistName)
                              ],
                            ),
                            // icon heart
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite),
                              color: Colors.red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // song duragion progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // start time
                          Text(
                            formatTime(value.currentDuration),
                          ),
                          // shuffle icon
                          const Icon(Icons.shuffle),
                          // repaet icon
                          const Icon(Icons.repeat),
                          // end time
                          Text(
                            formatTime(value.totalDuration),
                          )
                        ],
                      ),
                    ),
                    // song duraction progress
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          // пользователь скользит вокруг
                        },
                        onChangeEnd: (double double) {
                          // слайд завершен, перейдти на эту позицию во время песни
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // play black controls
                    Row(
                      children: [
                        // skip previous
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playPreviousSong,
                                child: const NeuBox(
                                    child: Icon(Icons.skip_previous)))),
                        const SizedBox(
                          width: 15,
                        ),
                        // play paus
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                onTap: value.pausOrResume,
                                child: NeuBox(
                                    child: Icon(value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow)))),
                        const SizedBox(
                          width: 20,
                        ),
                        // skip forward
                        Expanded(
                            child: GestureDetector(
                                onTap: value.playNextSong,
                                child:
                                    const NeuBox(child: Icon(Icons.skip_next))))
                      ],
                    )
                  ],
                )
                // playback conrols
              ],
            ),
          ),
        ),
      );
    });
  }
}
