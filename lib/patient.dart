class Patient {
  String name;
  int age;
  double leucocytes;
  double glicemia;
  double ast;
  double ldh;
  bool hasBiliaryColic;

  Patient({
    required this.name,
    required this.age,
    required this.leucocytes,
    required this.glicemia,
    required this.ast,
    required this.ldh,
    required this.hasBiliaryColic,
  });
}