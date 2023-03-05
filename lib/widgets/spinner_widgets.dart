import 'package:flutter/material.dart';

class SpinnerWidget extends StatefulWidget {
  final String spinnerImage;
  final bool isSpin;
  final AnimationController controller;
  const SpinnerWidget(
      {super.key,
      required this.spinnerImage,
      required this.isSpin,
    required  this.controller});

  @override
  State<SpinnerWidget> createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<SpinnerWidget> {
  @override
  Widget build(BuildContext context) {
    double resHeight = MediaQuery.of(context).size.height;
    double resWight = MediaQuery.of(context).size.width;
    return SizedBox(
      width: resWight * 0.435,
      child: Stack(children: [
        Image.asset("assets/Graphics/gfx-reel.png"),
        SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(
                    0,
                    !widget.isSpin ? -0.15 : 0,
                  ),
                  end: const Offset(0, 0))
              .animate(widget.controller),
          child: Image.asset("assets/Graphics/${widget.spinnerImage}"),
        ),
      ]),
    );
  }
}
