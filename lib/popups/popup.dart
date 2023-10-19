import 'package:flutter/material.dart';
import 'package:technaid_test/constants/colors.dart';

class Popup extends StatelessWidget {
  final int index;

  const Popup(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Icon icon;
    late String text;
    late Color textColor;
    double iconSize = 30; // Tamaño del icono
    double textSize = 25; // Tamaño del texto

    if (index == 1) {
      backgroundColor = greenPatient;
      icon = Icon(
        Icons.thumb_up,
        size: iconSize,
        color: greenUp,
      );
      text = 'Patient scuccesfully added';
      textColor = greenUp;
    } else if (index == 2) {
      backgroundColor = greenPatient;
      icon = Icon(
        Icons.thumb_up,
        size: iconSize,
        color: greenUp,
      );
      text = 'Patient scuccesfully updated';
      textColor = greenUp;
    } else if (index == 3) {
      backgroundColor = redDown;
      icon = Icon(
        Icons.thumb_down,
        size: iconSize,
        color: redEliminate,
      );
      text = 'Patient scuccesfully Deleted';
      textColor = redEliminate;
    }

    return Container(
      color: Colors.transparent, // Fondo transparentes
      margin: const EdgeInsets.fromLTRB(
          15, 0, 15, 20), // Margen desde la parte inferior
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // Ancho de 100
          height: 100, // Alto de 50
          decoration: BoxDecoration(
            color: backgroundColor, // Color de fondo de la Row
            borderRadius: BorderRadius.circular(25), // Borde redondeado de 15
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
                    fontSize: textSize, fontFamily: "Futura", color: textColor),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
