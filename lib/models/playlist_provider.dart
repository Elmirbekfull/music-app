import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    // song 1
    Song(
        songName: "She Likes Another Boy",
        artistName: "Oscar Lang",
        albumArtImagePath: "assets/images/1.jpg",
        audioPatch: "audio/1.mp3"),
    // song 2
    Song(
        songName: "Girl of my dreams",
        artistName: "Guti",
        albumArtImagePath: "assets/images/2.jpg",
        audioPatch: "audio/2.mp3"),
    Song(
        songName: "Hate",
        artistName: "ThxSoMch",
        albumArtImagePath: "assets/images/3.jpg",
        audioPatch: "audio/3.mp3"),
    Song(
        songName: "I'm God ",
        artistName: "Clams Casino",
        albumArtImagePath: "assets/images/4.jpg",
        audioPatch: "audio/4.mp3"),
    Song(
        songName: "THE ONE WHO LOVE",
        artistName: "HVZVRD, DIXSDAIN",
        albumArtImagePath: "assets/images/5.jpg",
        audioPatch: "audio/5.mp3"),
    Song(
        songName: "Lovers Rock",
        artistName: "TV Girl",
        albumArtImagePath: "assets/images/6.jpg",
        audioPatch: "audio/6.mp3"),
    Song(
        songName: "Embrace",
        artistName: "Pastel Ghost",
        albumArtImagePath: "assets/images/7.jpg",
        audioPatch: "audio/7.mp3"),
    Song(
        songName: "Mareux",
        artistName: "Killer",
        albumArtImagePath: "assets/images/8.jpg",
        audioPatch: "audio/8.mp3"),
    Song(
        songName: "ecstacy (slowed)",
        artistName: "SUICIDAL - IDOL",
        albumArtImagePath: "assets/images/9.jpg",
        audioPatch: "audio/9.mp3"),
    Song(
        songName: "KXLLSWXTCH",
        artistName: "SUICIDAL - IDOL",
        albumArtImagePath: "assets/images/10.jpg",
        audioPatch: "audio/10.mp3"),
  ];

  // индекс воспроизведения текущей песни
  int? _currentSongIndex;

  // АУДИОПЛЕЕР

  final AudioPlayer _audioPlayer = AudioPlayer();

  // ПРОДОЛЖИТЕЛЬНОСТЬ
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // КОНСТРУКТОР

  PlayListProvider() {
    listenToDuration();
  }

  // НЕ ИГРАТЬ ИЗНАЧАЛЬНО
  bool _isPlaying = false;

  // ИГРАТЬ ПЕСНЮ

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPatch;
    await _audioPlayer.stop(); // остановить текущую песню
    await _audioPlayer.play(AssetSource(path)); // начать новую песню
    _isPlaying = true;
    notifyListeners();
  }

  // ПАУЗА ТЕКУЩЕЙ ПЕСНИ
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // ВОЗОБНОВИТЬ
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // ПАУЗА ИЛИ ВОЗОБНОВЛЕНИЕ
  void pausOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // ИСКАТЬ КОНКРЕТНУЮ ПОЗИЦИЮ В ТЕКУЩЕЙ ПЕСНЕ
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // ВОСПРОИЗВЕСТИ СЛЕДУЮЩУЮ ПЕСНЮ
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // переход к следующей песне, если это не последняя песня
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // если это последняя песня, возвращаемся к первой песне
        currentSongIndex = 0;
      }
    }
  }

  // ВОСПРОИЗВЕДЕНИЕ ПРЕДЫДУЩЕЙ ПЕСНИ
  void playPreviousSong() async {
    // если прошло более 2 секунд, перезапускаем текущую песню
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
      // если это происходит в течение первых 2 секунд песни, переходим к предыдущей песне
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // если это первая песня, возвращаемся к последней песне
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // СПИСОК ПРОДОЛЖИТЕЛЬНОСТИ
  void listenToDuration() {
    // прослушивать общую продолжительность
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // прослушивать текущую продолжительность
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    // слушать конец песни
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // GET
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // SET
  set currentSongIndex(int? newIndex) {
    // обновить индекс текущей песни
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
      // проигрывать песню по новому индексу
    }
    // обнова UI
    notifyListeners();
  }
}
