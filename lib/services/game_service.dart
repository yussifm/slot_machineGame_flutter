import 'dart:math';

import 'package:just_audio/just_audio.dart';

class GameService {
  final _player = AudioPlayer();

  int yourCoins = 100;
  int highScore = 0;
  bool coin10 = true;
  List<int> reels = [0, 1, 2];

  List<String> items = [
    "gfx-bell.png",
    "gfx-cherry.png",
    "gfx-coin.png",
    "gfx-grape.png",
    "gfx-seven.png",
    "gfx-strawberry.png",
  ];

  // Spin func

  spin() {
    playSound('spin');

    int spinAmount = coin10 ? 10 : 20;
    if (spinAmount <= yourCoins) {
      reels = List.generate(3, (_) => Random().nextInt(items.length));
      if (reels[0] == reels[1] && reels[2] == reels[2]) {
        if (coin10) {
          playSound("high-score");
          yourCoins = yourCoins + 10 * 10;
        } else {
          playSound("high-score");
          yourCoins = yourCoins + 20 * 10;
        }

        if (yourCoins > highScore) {
          highScore = yourCoins;
        }
        playSound("win");
        return 'WIN'.toUpperCase();
      } else {
        if (coin10) yourCoins = yourCoins - 10;
        if (!coin10) yourCoins = yourCoins - 20;

        if (yourCoins <= 0) {
          playSound("game-over");
          return "Game End".toUpperCase();
        }
      }
    } else {
      playSound("game-over");
      return "Game End".toUpperCase();
    }
  }

  playSound(soundName) async {
    await _player.setAsset("assets/Sounds/$soundName.mp3");
    _player.play();
  }

  reset() {
    yourCoins = 100;
    playSound("chimeup");
  }
}
