import 'package:flutter/material.dart';
import 'package:technaid_test/constants/colors.dart';

class DialogPatient extends StatelessWidget {
  const DialogPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
            child: Text(
          "Create new patient",
          style: TextStyle(
            fontSize: 23,
            fontFamily: "Futura",
            fontWeight: FontWeight.w100,
          ),
        )),
        const SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            hintText: '* Name',
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Futura",
            ),
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: '* Surname',
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Futura",
            ),
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: '* Birthday',
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Futura",
            ),
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          onTap: () {
            // Show date picker here
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: '* Gender',
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Futura",
            ),
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        const SizedBox(height: 21),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 120,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 214, 214),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 209, 204, 204),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0)
                  ]),
              child: TextButton(
                onPressed: () {
                  // Add your cancel action here
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(221, 144, 138, 138),
                    fontFamily: "Futura",
                  ),
                ),
              ),
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: blueLetters,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () {
                  // Add your save action here
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "Futura",
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
