import 'package:flutter/material.dart';

class Specialite {
  final int id;
  final String titre, description, imageSrc;
  final String agenda;
  final Color color;

  Specialite({
    required this.id,
    required this.titre,
    required this.description,
    required this.imageSrc,
    required this.color,
    required this.agenda
  });
}

List<Specialite> specialites = [
  Specialite(id: 1, titre: "Généralité", description: "Faites vous diagnostiquer", imageSrc: "assets/images/fever.png", color: Colors.lightBlue, agenda: "GENERALISTE"),
  Specialite(id: 2, titre: "Pédiatrie", description: "La santé de votre enfant", imageSrc: "assets/images/pediatrics.png", color: Colors.pink, agenda: "PEDIATRIE"),
  Specialite(id: 3, titre: "Cardiologie", description: "La santé de votre coeur", imageSrc: "assets/images/cardiology.png", color: Colors.redAccent, agenda: "CARDIOLOGIE"),
  Specialite(id: 4, titre: "Ophthalmologie", description: "Vos yeux sont chers", imageSrc: "assets/images/ophthalmology.png", color: Colors.pinkAccent, agenda: "OPHTHALMOLOGIE"),
  Specialite(id: 5, titre: "Maternité", description: "Nous venons tous de là", imageSrc: "assets/images/maternity.png", color: Colors.orange, agenda: "MATERNITE"),
  Specialite(id: 6, titre: "Gynécologie", description: "Votre bien-être", imageSrc: "assets/images/gynecology.png", color: Colors.pinkAccent, agenda: "GYNECOLOGIE"),
];