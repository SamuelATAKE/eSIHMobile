import 'package:esihapp/backend/model/Jour.dart';
import 'package:intl/intl.dart';

class TrancheHoraire {
  TrancheHoraire({ id, heureDebut, heureFin, commentaire, jour });

  int id = 0;
  DateTime heureDebut = DateTime.now();
  DateTime heureFin = DateTime.now();
  String commentaire = "";
  Jour jour = Jour();

  factory TrancheHoraire.fromMap(Map roleMap) {
    return TrancheHoraire(
        id: roleMap['id'] as int,
      // heureDebut: DateTime.parse(roleMap['heureDebut'].toString()),
        heureDebut: DateFormat("hh:mm:ss").parse(roleMap['heureDebut']),
        heureFin: DateFormat("hh:mm:ss").parse(roleMap['heureFin']),
        commentaire: roleMap['commentaire'].toString(),
        jour: Jour.fromMap(roleMap['jour']),
    );
  }

  @override
  String toString() {
    return '{ ${id}, ${heureDebut}, ${heureFin}, ${commentaire}, ${jour} }';
  }
}