import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/constants/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Hi, Welcome",
              style: TextStyle(
                color: blueLetters,
                fontSize: 28.0,
                fontWeight: FontWeight.w300,
                fontFamily: "Futura",
              ),
            ),
            Text(
              getCurrentDate(),
              style: const TextStyle(
                color: blueLetters,
                fontSize: 23.0,
                fontWeight: FontWeight.w100,
                fontFamily: "Futura",
              ),
            ),
          ],
        ),
        backgroundColor: greyBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Patient List",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Futura",
                fontWeight: FontWeight.w100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Full name",
                      contentPadding:
                          const EdgeInsets.all(10.0), // Espacio interior
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15.0), // Esquinas redondeadas
                        borderSide: const BorderSide(
                          color: Colors.black, // Color del borde
                          width: 1.0, // Ancho del borde
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: "Futura",
                      fontWeight: FontWeight.w100,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(
                          16), // Ajusta el espaciado según tus necesidades
                      backgroundColor: blueLetters, // Define el color del botón
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blueAddButton,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
