class PatientData {
  final String name;
  final String surname;
  final DateTime? birthday;
  final String? gender;

  PatientData({
    required this.name,
    required this.surname,
    this.birthday,
    this.gender,
  });
}
