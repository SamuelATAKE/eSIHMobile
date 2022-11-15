import 'package:esihapp/backend/model/Jour.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:intl/intl.dart';

class RendezVous {
  RendezVous({id, date, heureDebut, heureFin, patient, jour, description});

  int id = 0;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String heureDebut = DateFormat('hh:mm:ss').format(DateTime.now());
  String heureFin = DateFormat('hh:mm:ss').format(DateTime.now());
  String description = "";
  Personne patient = Personne();
  Jour jour = Jour();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "date": date.toString(),
      "heure": heureDebut.toString(),
      "heureFin": heureFin.toString(),
      "description": description,
      "patient": patient.toMap(),
      "jour": jour.toMap(),
    };
  }

  @override
  String toString() {
    return '{ ${id}, ${date}, ${heureDebut}, ${heureFin}, ${patient}, ${jour}, ${description} }';
  }
}
