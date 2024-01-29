import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the playlist provider
  late final dynamic playListProvider;
  @override
  void initState() {
    super.initState();
    // get the playlist provider
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  // go to song
  void goToSong(int songIndex) {
    // update current song index
    playListProvider.currentSongIndex = songIndex;
    // navigate to song page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "АУДИОПЛЕЙЛИСТ",
        ),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(builder: (context, value, child) {
        // get the playlist
        final List<Song> playlist = value.playlist;
        // return list view UI
        return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // get individual song
              final Song song = playlist[index];
              // return list Tile UI
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            });
      }),
    );
  }
}
