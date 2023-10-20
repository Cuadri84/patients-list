import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/constants/colors.dart';
import '../dialogs/edit_dialog.dart';
import '../models/patient_model.dart';
import '../popups/popup.dart';

class SinglePatient extends StatefulWidget {
  final PatientData patient;
  final bool isSelected;
  final List<PatientData> filteredPatients;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<PatientData> onEdit;

  const SinglePatient({
    Key? key,
    required this.patient,
    required this.isSelected,
    required this.filteredPatients,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  SinglePatientState createState() => SinglePatientState();
}

class SinglePatientState extends State<SinglePatient> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: greyBackground,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: widget.isSelected ? Colors.black : Colors.transparent,
              width: widget.isSelected ? 1.0 : 0.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Expanded(
                //Shows name, birthdate and gender
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.patient.name} ${widget.patient.surname}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Futura",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Birthdate: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Futura",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: DateFormat('MMMM dd, yyyy')
                                .format(widget.patient.birthday!),
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Futura",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Gender: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Futura",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.patient.gender ?? "N/A",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Futura",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //edit,delete icons
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                      size: 33,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Stack(
                              children: [
                                SizedBox(
                                  width: 500,
                                  height: 391,
                                  child: EditDialog(
                                    patient: widget.patient,
                                    onEdit: (editedPatient) {
                                      widget.onEdit(editedPatient);
                                    },
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
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: redEliminate,
                      size: 33,
                    ),
                    onPressed: () {
                      widget.onDelete();

                      // Shows popup deleted patient
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Uses Popup with index 3
                          const popup = Popup(
                              3); // Utiliza el índice 3 para Usuario eliminado
                          Future.delayed(const Duration(seconds: 2), () {
                            //Closes popup after 2 seconds
                            Navigator.of(context).pop();
                          });

                          return popup;
                        },
                      );
                    },
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: blueLetters,
                    size: 33,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
