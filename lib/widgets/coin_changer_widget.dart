import 'package:flutter/material.dart';
import 'package:slot_game_flutter/helpers/colors.dart';

class CoinChangerWidget extends StatelessWidget {
  final bool isTrue;
  final String coinValue;
  const CoinChangerWidget(
      {super.key, required this.isTrue, required this.coinValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, 
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [kprimarycolor, ksecondarycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(color: kprimarycolor),
      ),
      child: Center(
        child: Text(
          coinValue,
          style: TextStyle(
            color: isTrue ? kyellowcolor : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
