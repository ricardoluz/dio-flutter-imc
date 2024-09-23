import 'package:dio_imc/models/bmi_notes.dart';

class BmiNotesRepository {
  final List<BmiNote> _bmiNotes = [];

  Future<List<BmiNote>> getBmiNotes() async {
    simulation(time: 200);
    return _bmiNotes;
  }

  Future<void> addBmiNotes(BmiNote bmiNote) async {
    simulation(time: 200);
    _bmiNotes.add(bmiNote);
  }

  Future<void> removeBmiNotes(String id) async {
    simulation(time: 200);
    _bmiNotes.remove(_bmiNotes.where((task) => task.id == id).first);
  }
}

Future<void> simulation({required int time}) async {
  await Future.delayed(Duration(milliseconds: time)); //Simulation
}
