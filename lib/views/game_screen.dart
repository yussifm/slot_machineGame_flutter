import 'package:flutter/material.dart';
import 'package:slot_game_flutter/helpers/colors.dart';
import 'package:slot_game_flutter/services/game_service.dart';
import 'package:slot_game_flutter/widgets/coin_changer_widget.dart';
import 'package:slot_game_flutter/widgets/spinner_widgets.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  GameService gameService = GameService();
  late final AnimationController spinController;
  late final AnimationController controller;

  @override
  void initState() {
    spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
    gameService.playSound("riseup");
    controller.forward();
    spinController.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double resHeight = MediaQuery.of(context).size.height;
    double resWight = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [kprimarycolor, ksecondarycolor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          children: [
            SizedBox(
              height: resHeight * 0.075,
            ),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      gameService.reset();
                    });
                  },
                  icon: const Icon(
                    Icons.restart_alt_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Image.asset(
                  "assets/Graphics/gfx-slot-machine.png",
                  width: resWight * 0.6,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),

            //

            SizedBox(
              height: resHeight * 0.02,
            ),

            // Scoreboard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your\nCOINS".toUpperCase(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "${gameService.yourCoins}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "${gameService.highScore}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "high\nscore".toUpperCase(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(
              height: resHeight * 0.02,
            ),
            Column(
              children: [
                SpinnerWidget(
                  spinnerImage: gameService.items[gameService.reels[0]],
                  isSpin: false,
                  controller: spinController,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SpinnerWidget(
                      spinnerImage: gameService.items[gameService.reels[1]],
                      isSpin: false,
                      controller: spinController,
                    ),
                    SpinnerWidget(
                      spinnerImage: gameService.items[gameService.reels[2]],
                      isSpin: false,
                      controller: spinController,
                    ),
                  ],
                ),

                //
                GestureDetector(
                  onTap: () {
                    spinController.forward(from: 0);
                    var spin = gameService.spin();
                    if (spin == "Game end".toUpperCase()) {
                      showPopup("Game end".toUpperCase());
                    }
                    if (spin == "win".toUpperCase()) {
                      showPopup("win".toUpperCase());
                    }
                    setState(() {});
                  },
                  child: SpinnerWidget(
                    spinnerImage: 'gfx-spin.png',
                    isSpin: true,
                    controller: spinController,
                  ),
                ),

                SizedBox(
                  height: resHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        gameService.playSound('casino-chips');
                        setState(() {
                          gameService.coin10 = true;
                          controller.forward(from: 0);
                        });
                      },
                      child: CoinChangerWidget(
                          isTrue: gameService.coin10, coinValue: "10"),
                    ),
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, 0),
                              end: Offset(gameService.coin10 ? -2 : 2, 0))
                          .animate(controller),
                      child: Image.asset(
                        "assets/Graphics/gfx-casino-chips.png",
                        height: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        gameService.playSound('casino-chips');
                        setState(() {
                          gameService.coin10 = false;
                          controller.forward(from: 0);
                        });
                      },
                      child: CoinChangerWidget(
                          isTrue: !gameService.coin10, coinValue: "20"),
                    ),
                  ],
                ),
                SizedBox(
                  height: resHeight * 0.02,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showPopup(type) {
    double resHeight = MediaQuery.of(context).size.height;
    double resWight = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              height: resHeight * 0.3,
              width: resWight * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: Column(
                    children: [
                      Container(
                        width: resWight * 0.9,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [kprimarycolor, ksecondarycolor],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              type == "Game end".toUpperCase()
                                  ? "Game Over".toUpperCase()
                                  : "YOU WIN".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/Graphics/gfx-seven-reel.png",
                        width: 100,
                      ),
                      const Spacer(),
                      Text(
                        type == "Game end".toUpperCase()
                            ? "Bad Luck! You Lost all of your coins.\nLet's play again"
                            : "Hurry! You Win the spin. \nLet's play more",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 17),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          if (type == "Game end".toUpperCase) {
                            Navigator.of(context).pop();
                            setState(() {
                              gameService.reset();
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(kprimarycolor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(
                                  color: kprimarycolor, width: 3),
                            ),
                          ),
                        ),
                        child: Text(
                          type == "Game end".toUpperCase()
                              ? "New Game".toUpperCase()
                              : "continue".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
