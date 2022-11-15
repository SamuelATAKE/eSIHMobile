import 'dart:convert';

import 'Personne.dart';

class Jour {
  Jour({ id, date, commentaire, personne });
  int id = 0;
  String date = "";
  String commentaire = "";
  Personne personne = Personne();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "date": date,
      "commentaire": commentaire,
      "personne": personne.toMap()
    };
  }

  factory Jour.fromMap(Map roleMap) {
    return Jour(
      id: roleMap['id'] as int,
      date: roleMap['date'] as String,
      commentaire: roleMap['commentaire'] as String,
      personne: Personne.fromMap(roleMap['personne'])
    );
  }

  List<Jour> joursFromJSON(String str) => List<Jour>.from(json.decode(str).map((x) => Jour.fromMap(x)));

  @override
  String toString() {
    return '{ ${id}, ${date}, ${commentaire}, ${personne} }';
  }
}