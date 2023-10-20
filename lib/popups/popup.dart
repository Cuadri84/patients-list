import 'package:flutter/material.dart';
import 'package:technaid_test/constants/colors.dart';

class Popup extends StatefulWidget {
  final int index;

  const Popup(this.index, {super.key});

  @override
  PopupState createState() => PopupState();
}

class PopupState extends State<Popup> with TickerProviderStateMixin {
  // Initialize variables for colors, icons, and text.
  late Color backgroundColor;
  late Icon icon;
  late String text;
  late Color textColor;
  double iconSize = 30;
  double textSize = 25;

  // Initialize animation controller and animation for sliding.
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Create an animation controller with a 500 milliseconds (0.5 seconds) duration.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define the slide animation from a beginning offset of 100 to an end offset of 0.
    _slideAnimation = Tween<double>(begin: 100, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Start the animation when the widget is first built.
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the appearance of the Popup based on the provided index.
    if (widget.index == 1) {
      backgroundColor = greenPatient;
      icon = Icon(
        Icons.thumb_up,
        size: iconSize,
        color: greenUp,
      );
      text = 'Patient successfully added';
      textColor = greenUp;
    } else if (widget.index == 2) {
      backgroundColor = greenPatient;
      icon = Icon(
        Icons.thumb_up,
        size: iconSize,
        color: greenUp,
      );
      text = 'Patient successfully updated';
      textColor = greenUp;
    } else if (widget.index == 3) {
      backgroundColor = redDown;
      icon = Icon(
        Icons.thumb_down,
        size: iconSize,
        color: redEliminate,
      );
      text = 'Patient successfully Deleted';
      textColor = redEliminate;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 20,
                    ),
                    icon,
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: textSize,
                        fontFamily: "Futura",
                        color: textColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller to prevent memory leaks.
    _controller.dispose();
    super.dispose();
  }
}
