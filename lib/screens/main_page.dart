import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../dialogs/dialog_patient.dart';
import '../models/patient_model.dart';
import '../widgets/single_patient.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // This function retrieves the current date in the "Month dd, yyyy" format.
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM dd, yyyy');
    return formatter.format(now);
  }

  // Index of the selected patient
  int selectedPatientIndex = -1;

  List<PatientData> patients = [];
  List<PatientData> filteredPatients = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
  }

  // Updates the user interface.
  void updateUI() {
    setState(() {});
  }

  // Removes a patient from the list.
  void removePatient(PatientData patient) {
    setState(() {
      patients.remove(patient);
      filteredPatients = patients;
    });
  }

  // Searches for patients based on their name or surname.
  void searchPatients(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the search field is empty, display all patients.
        filteredPatients = patients;
      } else {
        // Filters the patient list based on name or surname.
        filteredPatients = patients.where((patient) {
          final fullName = '${patient.name} ${patient.surname}';
          return fullName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  // Allows editing a patient's information in the list.
  void onEdit(PatientData editedPatient, int index) {
    if (index >= 0 && index < patients.length) {
      // Make sure the index is valid and updates the patient in the list
      patients[index] = editedPatient;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (selectedPatientIndex >= 0 &&
                selectedPatientIndex < filteredPatients.length)
              // Display patient's name if one is selected.
              Expanded(
                child: Text(
                  '${filteredPatients[selectedPatientIndex].name} ${filteredPatients[selectedPatientIndex].surname}',
                  style: const TextStyle(
                    color: blueLetters,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Futura",
                  ),
                ),
              )
            else
              // Display a welcome message if no patient is selected.
              const Text(
                "Hi, Welcome",
                style: TextStyle(
                  color: blueLetters,
                  fontSize: 28.0,
                  fontFamily: "Futura",
                ),
              ),
            if (selectedPatientIndex >= 0)
              // Display patient information when a patient is selected.
              const Row(
                children: [
                  Text(
                    "Device 01H-Jk-012",
                    style: TextStyle(
                      color: blueLetters,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: "Futura",
                    ),
                  ),
                  Icon(Icons.bluetooth),
                  Icon(Icons.battery_charging_full),
                  Icon(Icons.arrow_drop_down),
                ],
              )
            else
              // Display the current date if no patient is selected.
              Text(
                getCurrentDate(),
                style: const TextStyle(
                  color: blueLetters,
                  fontSize: 20.0,
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
      body: GestureDetector(
        onTap: () {
          //Dismiss keyboard if the textfield is not press
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          //Selects the touched patient
          setState(() {
            selectedPatientIndex = -1;
          });
        },
        child: Center(
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
              //If list of patients is empty displays a text
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
                  //If list is not empty displays the patients
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredPatients.length,
                        itemBuilder: (BuildContext context, int index) {
                          final patient = filteredPatients[index];
                          return SinglePatient(
                            patient: patient,
                            isSelected: index == selectedPatientIndex,
                            filteredPatients: filteredPatients,
                            onTap: () {
                              setState(() {
                                selectedPatientIndex = index;
                              });
                            },
                            onDelete: () {
                              removePatient(patient);
                            },
                            onEdit: (editedPatient) {
                              onEdit(editedPatient, index);
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),

      //FAB thats shows the dialog to add new patients
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
