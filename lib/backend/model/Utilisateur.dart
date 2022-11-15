import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/backend/model/Role.dart';

class Utilisateur {
  Utilisateur.NewUtilisateur({
    //required this.id,
    required this.userName,
    required this.password,
    //required this.active,
    // required this.role,
    // required this.personne
  });

  // Utilisateur.LogingUtilisateur(this.userName, this.password);

  int id = 0;
  String userName;
  String password;
  bool active = false;
  Role role = Role();
  Personne personne = Personne();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "username": userName,
      "password": password,
      "active": active,
      "role": role.toMap(),
      "personne": personne.toMap(),
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "username": userName,
      "password": password,
      "active": active,
      "role": role.toMap(),
      "personne": personne.toMap(),
    };
  }

  Map<String, dynamic> toRegisterMap() {
    return <String, dynamic>{
      "id": id,
      "username": userName,
      "password": password,
      "role": role,
      "personne": personne.id,
    };
  }

  factory Utilisateur.fromMap(Map userMap) {
    var utilisateur = Utilisateur.NewUtilisateur(
      // id: userMap['id'],
      userName: userMap['username'],
      password: userMap['password'],
      // active: userMap['active'],
      // role: userMap['role'],
      // personne: userMap['personne'],
    );
    utilisateur.id = userMap['id'];
    utilisateur.active = userMap['active'];
    utilisateur.role = Role.fromMap(userMap['role']);
    // utilisateur.personne = Personne.fromMap(userMap['personne']);
    utilisateur.personne.id = userMap['personne']['id'];
    utilisateur.personne.nom = userMap['personne']['nom'];
    utilisateur.personne.prenom = userMap['personne']['prenom'];
    utilisateur.personne.email = userMap['personne']['email'];
    utilisateur.personne.genre = userMap['personne']['genre'];
    utilisateur.personne.adresseResidence =
        userMap['personne']['adresseResidence'];
    utilisateur.personne.contact1 = userMap['personne']['contact1'];
    utilisateur.personne.dateNaissance = userMap['personne']['dateNaissance'];
    utilisateur.personne.profession = userMap['personne']['profession'];
    utilisateur.personne.matricule = userMap['personne']['matricule'];
    utilisateur.personne.specialite = userMap['personne']['specialite'];
    utilisateur.personne.groupeSanguin = userMap['personne']['groupeSanguin'];
    utilisateur.personne.sousTraitement = userMap['personne']['sousTraitement'];
    utilisateur.personne.traitementCourant =
        userMap['personne']['traitementCourant'];
    utilisateur.personne.alergie = userMap['personne']['alergie'];
    utilisateur.personne.deGarde = userMap['personne']['deGarde'];
    utilisateur.personne.fonction = userMap['personne']['fonction'];
    utilisateur.personne.assure = userMap['personne']['assure'];
    return utilisateur;
  }

  factory Utilisateur.fromJson(Map userMap) {
    var utilisateur = Utilisateur.NewUtilisateur(
      // id: userMap['id'],
      userName: userMap['username'],
      password: userMap['password'],
      // active: userMap['active'],
      // role: userMap['role'],
      // personne: userMap['personne'],
    );
    utilisateur.id = userMap['id'];
    utilisateur.active = userMap['active'];
    utilisateur.role = userMap['role'];
    utilisateur.personne = userMap['personne'];
    return utilisateur;
  }
}
