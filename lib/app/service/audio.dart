import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  AudioPlayer? _currentPlayer;
  List<String> playlist = [];
  int currentIndex = 0;

  bool isPlayerCompleteListenerInitialized = false;

  play(AudioPlayer player) async {
    setPlayer(player);

    if (playlist.isNotEmpty) {
      await player.play(UrlSource(playlist[currentIndex]));

      if (!isPlayerCompleteListenerInitialized) {
        player.onPlayerComplete.listen((event) {
          playNextSong(player);
        });

        isPlayerCompleteListenerInitialized = true;
      }
    }
  }

  setPlayer(AudioPlayer player) async {
    if (_currentPlayer != null &&
        _currentPlayer!.playerId != player.playerId) {}
    _currentPlayer = player;
  }

  pause(AudioPlayer player) {
    player.pause();
  }

  Future<void> playNextSong(AudioPlayer player) async {
    int nextIndex = (currentIndex + 1) % playlist.length;
    currentIndex = nextIndex;
    play(player);
  }

  Future<void> playPreviousSong(AudioPlayer player) async {
    currentIndex = currentIndex > 0 ? currentIndex - 1 : playlist.length - 1;
    play(player);
  }

  Future<void> stop() async {
    if (_currentPlayer != null) {
      await _currentPlayer!.stop();
      _currentPlayer = null;
    }
  }
}
