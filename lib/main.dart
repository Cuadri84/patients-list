import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technaid Patient List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/woman.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: "Futura",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: 270,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 238, 240, 243),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                      color: Color.fromARGB(255, 13, 44, 69),
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Futura"),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
