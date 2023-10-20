import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/models/patient_model.dart';

import '../constants/colors.dart';
import '../popups/popup.dart';

class EditDialog extends StatefulWidget {
  final PatientData patient;
  final ValueChanged<PatientData> onEdit;

  const EditDialog({Key? key, required this.patient, required this.onEdit})
      : super(key: key);

  @override
  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  String? selectedEditGender;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Initializes the controllers of the patient
    nameController.text = widget.patient.name;
    surnameController.text = widget.patient.surname;
    birthdayController.text =
        DateFormat('MMMM dd, yyyy').format(widget.patient.birthday!);
    selectedEditGender = widget.patient.gender;
    selectedDate = widget.patient.birthday;
  }

  // Opens a date picker dialog to allow the user to select a date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    setState(() {
      selectedDate = picked;
      birthdayController.text = selectedDate != null
          ? DateFormat('MMMM dd, yyyy').format(selectedDate!)
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Center(
        child: Text(
          "Edit Patient",
          style: TextStyle(
            fontSize: 23,
            fontFamily: "Futura",
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      const SizedBox(height: 15),

      //Field for the name
      TextFormField(
        controller: nameController,
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

      //Field for the surname
      TextFormField(
        controller: surnameController,
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

      //Field to select the birthdate
      TextField(
        onTap: () {
          _selectDate(context);
        },
        decoration: InputDecoration(
          hintText: '* Birthdate',
          hintStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: "Futura",
          ),
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          suffixIcon: const InkWell(
            child: Icon(Icons.event),
          ),
        ),
        readOnly: true,
        controller: TextEditingController(
          text: selectedDate != null
              ? DateFormat('MMMM dd, yyyy').format(selectedDate!)
              : "",
        ),
      ),
      const SizedBox(height: 8),

      //Field to select the gender
      TextFormField(
        controller: TextEditingController(text: selectedEditGender ?? "Male"),
        decoration: InputDecoration(
          hintText: 'Select Gender',
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
        readOnly: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Select Gender"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("Male"),
                      onTap: () {
                        setState(() {
                          selectedEditGender = "Male";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text("Female"),
                      onTap: () {
                        setState(() {
                          selectedEditGender = "Female";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text("Other"),
                      onTap: () {
                        setState(() {
                          selectedEditGender = "Other";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      const SizedBox(height: 21),

      //Cancel and Save  buttons
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                  spreadRadius: 0,
                )
              ],
            ),
            child: TextButton(
              //Closes the dialog if we don´t want to add a new patient
              onPressed: () {
                Navigator.of(context).pop();
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
                // Edits the patient and closes the dialog
                final editedPatient = PatientData(
                  name: nameController.text,
                  surname: surnameController.text,
                  birthday: DateFormat('MMMM dd, yyyy')
                      .parse(birthdayController.text),
                  gender: selectedEditGender,
                );

                widget.onEdit(editedPatient);

                // Closes the dialog
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Uses PopUp nº2
                    const popup = Popup(2);
                    // Close the popup after 2 seconds
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                    });

                    return popup;
                  },
                );
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
    ]);
  }
}
