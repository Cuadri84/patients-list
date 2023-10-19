import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technaid_test/models/patient_model.dart';

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
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los datos del paciente
    nameController.text = widget.patient.name;
    surnameController.text = widget.patient.surname;
    birthdayController.text =
        DateFormat('MMMM dd, yyyy').format(widget.patient.birthday!);
    genderController.text = widget.patient.gender ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Paciente'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: surnameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: birthdayController,
              decoration:
                  const InputDecoration(labelText: 'Fecha de Nacimiento'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Género'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Realiza la edición del paciente y cierra el diálogo
            final editedPatient = PatientData(
              name: nameController.text,
              surname: surnameController.text,
              birthday:
                  DateFormat('MMMM dd, yyyy').parse(birthdayController.text),
              gender: genderController.text,
            );

            widget.onEdit(editedPatient);
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                const popup =
                    Popup(2); // Utiliza el índice 3 para Usuario eliminado
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context)
                      .pop(); // Cierra el popup después de 1 segundo
                });

                return popup;
              },
            );
          },
          child: const Text('Guardar'),
        ),
        TextButton(
          onPressed: () {
            // Cierra el diálogo sin realizar cambios
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
