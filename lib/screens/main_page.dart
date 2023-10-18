import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/constants/colors.dart';
import 'package:technaid_test/dialogs/dialog_patient.dart';

import '../models/patient_model.dart';
import '../widgets/single_patient.dart';

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

  List<PatientData> patients = [];
  List<PatientData> filteredPatients = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  void updateUI() {
    setState(() {});
  }

  void removePatient(PatientData patient) {
    setState(() {
      patients.remove(patient);
      filteredPatients = patients;
    });
  }

  void searchPatients(String query) {
    setState(() {
      if (query.isEmpty) {
        // Si el campo de búsqueda está vacío, muestra todos los pacientes
        filteredPatients = patients;
      } else {
        // Filtra la lista de pacientes según el nombre o el apellido
        filteredPatients = patients.where((patient) {
          final fullName = '${patient.name} ${patient.surname}';
          return fullName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
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
                      controller: searchController,
                      onChanged: (value) {
                        searchPatients(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Full name",
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "Futura",
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      searchPatients(searchController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: blueLetters,
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
            patients.isEmpty
                ? const Text(
                    "Empty List",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.redAccent,
                      fontFamily: "Futura",
                      fontWeight: FontWeight.w100,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (BuildContext context, int index) {
                        final patient = filteredPatients[index];
                        return SinglePatient(
                          patient: patient,
                          onDelete: () {
                            removePatient(patient);
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 500,
                      height: 391,
                      child: DialogPatient(
                        patients: patients,
                        updateUI: updateUI,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(1),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
