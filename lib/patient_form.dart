import 'package:flutter/material.dart';
import 'mortality_calculator.dart';
import 'patient.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _leucocytesController = TextEditingController();
  final _glicemiaController = TextEditingController();
  final _astController = TextEditingController();
  final _ldhController = TextEditingController();
  final _hasBiliaryColicController = TextEditingController();

  late Patient _patient;
  late MortalityCalculator _mortalityCalculator;
  int _score = 0;
  double _mortality = 0.0;

  @override
  void initState() {
    super.initState();
    _mortalityCalculator = MortalityCalculator();
  }

  void _calculateMortality() {
    _patient = Patient(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      leucocytes: double.parse(_leucocytesController.text),
      glicemia: double.parse(_glicemiaController.text),
      ast: double.parse(_astController.text),
      ldh: double.parse(_ldhController.text),
      hasBiliaryColic: _hasBiliaryColicController.text.toLowerCase() == 'sim',
    );

    _score = _mortalityCalculator.calculateScore(_patient);
    _mortality = _mortalityCalculator.calculateMortality(_score);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do paciente';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a idade do paciente';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _leucocytesController,
                decoration: InputDecoration(labelText: 'Número de leucócitos'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de leucócitos';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _glicemiaController,
                decoration: InputDecoration(labelText: 'Valor da glicemia'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor da glicemia';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _astController,
                decoration: InputDecoration(labelText: 'Valor da AST/TGO'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor da AST/TGO';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ldhController,
                decoration: InputDecoration(labelText: 'Valor da LDH'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor da LDH';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hasBiliaryColicController,
                decoration: InputDecoration(labelText: 'Pancreatite com Litíase Biliar (sim/não)'),
                validator: (value) {
                  if (value == null ||
                      (value.toLowerCase() != 'sim' && value.toLowerCase() != 'não')) {
                    return 'Por favor, insira se a pancreatite tem ou não Litíase Biliar (sim/não)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculateMortality();
                  }
                },
                child: Text('Calcular Mortalidade'),
              ),
              SizedBox(height: 16),
              Visibility(
                visible: _score > 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pontuação: $_score'),
                    Text('Mortalidade: ${(_mortality * 100).toStringAsFixed(2)}%'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}