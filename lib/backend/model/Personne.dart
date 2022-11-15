import 'package:intl/intl.dart';

class Personne {
  Personne(
      {id,
      nom,
      prenom,
      email,
      genre,
      adresseResidence,
      contact1,
      contact2,
      dateNaissance,
      profession,
      matricule,
      specialite,
      groupeSanguin,
      sousTraitement,
      traitementCourant,
      alergie,
      deGarde,
      fonction,
      assure});

  int id = 0;
  String nom = "";
  String prenom = "";
  String email = "";
  String? genre;
  String adresseResidence = "";
  int contact1 = 0;
  int? contact2 = 0;
  String dateNaissance = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // String dateNaissance = "!I";
  String profession = "";
  String matricule = "";
  String specialite = "";
  String? groupeSanguin;
  bool sousTraitement = false;
  String traitementCourant = "";
  String? alergie = "";
  bool deGarde = false;
  String? fonction;
  bool assure = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "genre": genre,
      "adresseResidence": adresseResidence,
      "contact1": contact1,
      "contact2": contact2,
      "dateNaissance": dateNaissance.toString(),
      "profession": profession,
      "matricule": matricule,
      "specialite": specialite,
      "groupeSanguin": groupeSanguin,
      "sousTraitement": sousTraitement,
      "traitementCourant": traitementCourant,
      "alergie": alergie,
      "deGarde": deGarde,
      "fonction": fonction,
      "assure": assure,
    };
  }

  factory Personne.fromMap(Map roleMap) {
    return Personne(
      id: roleMap['id'] as int,
      nom: roleMap['nom'].toString(),
      prenom: roleMap['prenom'].toString(),
      email: roleMap['email'].toString(),
      genre: roleMap['genre'].toString(),
      adresseResidence: roleMap['adresseResidence'].toString(),
      contact1: roleMap['contact1'].toString(),
      contact2: roleMap['contact2'].toString(),
      dateNaissance: roleMap['dateNaissance'].toString(),
      profession: roleMap['profession'].toString(),
      matricule: roleMap['matricule'].toString(),
      specialite: roleMap['specialite'].toString(),
      groupeSanguin: roleMap['groupeSanguin'].toString(),
      sousTraitement: roleMap['sousTraitement'].toString(),
      traitementCourant: roleMap['traitementCourant'].toString(),
      alergie: roleMap['alergie'].toString(),
      deGarde: roleMap['deGarde'].toString(),
      fonction: roleMap['fonction'].toString(),
      assure: roleMap['assure'].toString(),
    );
  }

  @override
  String toString() {
    return '{ ${id}, ${nom}, ${prenom}, ${email}, ${genre}, ${adresseResidence}, ${contact1}, ${contact2}, ${dateNaissance}, ${profession}, ${matricule}, ${specialite}, ${groupeSanguin}, ${sousTraitement}, ${traitementCourant}, ${alergie}, ${profession}, ${matricule}, ${deGarde}, ${fonction}, ${assure} }';
  }
}
