import 'package:flutter/material.dart';
import 'package:technaid_test/constants/colors.dart';
import '../models/patient_model.dart';

class DialogPatient extends StatefulWidget {
  final List<PatientData> patients;
  final Function updateUI; // Agrega el parámetro updateUI de tipo Function
  const DialogPatient(
      {Key? key, required this.patients, required this.updateUI})
      : super(key: key);

  @override
  DialogPatientState createState() => DialogPatientState();
}

class DialogPatientState extends State<DialogPatient> {
  String? selectedGender;
  DateTime? selectedDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: nameController, // Controlador para el campo de nombre
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
          controller:
              surnameController, // Controlador para el campo de apellido
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
            suffixIcon: InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: const Icon(Icons.event),
            ),
          ),
          readOnly: true,
          controller: TextEditingController(
            text: selectedDate != null
                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                : "",
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
          items: <String>['male', 'female', 'other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          icon: const Icon(Icons.expand_more),
          borderRadius: BorderRadius.circular(15.0),
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
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextButton(
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
                  // Obtén los valores ingresados en el diálogo
                  String name = nameController.text;
                  String surname = surnameController.text;
                  DateTime? birthday = selectedDate;
                  String? gender = selectedGender;

                  if (name.isNotEmpty &&
                      surname.isNotEmpty &&
                      birthday != null) {
                    // Crea un nuevo objeto PatientData
                    PatientData newPatient = PatientData(
                      name: name,
                      surname: surname,
                      birthday: birthday,
                      gender: gender,
                    );

                    // Agrega el nuevo paciente a la lista
                    setState(() {
                      widget.patients.add(newPatient);
                    });

                    // Cierra el diálogo
                    Navigator.of(context).pop();
                    widget.updateUI();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please fill in all the required fields.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red, // Fondo rojo
                      ),
                    );
                    // Aquí puedes mostrar un mensaje de error o validar los campos según tus necesidades
                  }
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
