import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                color: Color.fromARGB(255, 13, 44, 69),
                fontSize: 28.0,
                fontWeight: FontWeight.w300,
                fontFamily: "Futura",
              ),
            ),
            Text(
              getCurrentDate(),
              style: const TextStyle(
                color: Color.fromARGB(255, 13, 44, 69),
                fontSize: 23.0,
                fontWeight: FontWeight.w100,
                fontFamily: "Futura",
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[200], // Fondo gris claro
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              "Patient List",
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: "Futura",
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 12, 78, 129),
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
