import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/constants/colors.dart';
import '../dialogs/edit_dialog.dart';
import '../models/patient_model.dart';
import '../popups/popup.dart';

class SinglePatient extends StatefulWidget {
  final PatientData patient;
  final bool isSelected;
  final List<PatientData> filteredPatients; // Pasar solo la lista filtrada
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<PatientData> onEdit; // Agrega el parámetro onEdit

  const SinglePatient({
    Key? key,
    required this.patient,
    required this.isSelected,
    required this.filteredPatients,
    required this.onTap,
    required this.onDelete,
    required this.onEdit, // Añade el parámetro onEdit
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
              color: widget.isSelected
                  ? Colors.black
                  : Colors.transparent, // Aplica el borde según isSelected
              width: widget.isSelected ? 1.0 : 0.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Expanded(
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
                              fontWeight:
                                  FontWeight.bold, // Estilo para "Gender:"
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
                          return EditDialog(
                            patient: widget.patient,
                            onEdit: (editedPatient) {
                              // Aquí puedes realizar las actualizaciones necesarias en el paciente.
                              widget.onEdit(editedPatient);
                            },
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
                      // Realiza la lógica de eliminación aquí, por ejemplo:
                      widget.onDelete();

                      // Luego, muestra el popup "Usuario eliminado".
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          const popup = Popup(
                              3); // Utiliza el índice 3 para Usuario eliminado
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context)
                                .pop(); // Cierra el popup después de 1 segundo
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
