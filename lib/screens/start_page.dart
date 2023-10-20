import 'package:flutter/material.dart';
import 'package:technaid_test/constants/colors.dart';
import 'package:technaid_test/screens/main_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          //Background image of the woman walking
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
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 90),
          SizedBox(
            width: 270,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the MainPage when the button is pressed.
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greyBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                    color: blueLetters,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w100,
                    fontFamily: "Futura"),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
