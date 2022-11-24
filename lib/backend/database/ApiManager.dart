// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';

import 'package:esihapp/backend/model/Jour.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/backend/model/RendezVous.dart';
import 'package:esihapp/backend/model/Role.dart';
import 'package:esihapp/backend/model/Slot.dart';
import 'package:esihapp/backend/model/TrancheHoraire.dart';
import 'package:esihapp/backend/model/User.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiManager {
  ApiManager._();
  static final ApiManager instance = ApiManager._();
  static const String apiUrl = "http://192.168.1.72:8080";
  // static const String apiUrl = "http://192.168.1.102:8080";

  var patientUrl = "$apiUrl/api/utilisateur/patient";
  var userUrl = "$apiUrl/api/utilisateur";
  var personneUrl = "$apiUrl/api/personne";
  var authUrl = Uri.parse("$apiUrl/authenticate");
  var authAdminUrl = Uri.parse("$apiUrl/authenticate-admin");
  var roleUrl = Uri.parse("$apiUrl/api/role/5");

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  dynamic authToken = SessionManager().get("token");

  final storage = new FlutterSecureStorage();

  // static const Map<String, String> secureHeaders = {
  //   "Content-Type": "application/json",
  //   "Authorization": "Bearer " + token,
  // };

  // Méthode de connexion
  Future<int> login(User user) async {
    var session = SessionManager();
    var body = jsonEncode(user.toMap());
    var response = await http.post(authUrl, headers: headers, body: body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      session.set("token", response.body.toString());
      session.set("logged", true);

      Utilisateur loggedUser = await findByUsername(user.userName);
      print(loggedUser.personne);
      await storage.write(
          key: 'logUser', value: jsonEncode(loggedUser.toMap()));
    }

    var status = await response.statusCode;

    return status;
  }

  // Méthode d'ajout / création d'utilisateur
  Future<int> addUser(Utilisateur user, Personne personne) async {
    var session = SessionManager();
    var authentication = await authenticate();
    print("Auth token: $authentication");
    print("Le token");
    print("Bearer $authentication");
    user.role = await getRole();
    print("await role");
    print(user.role.toMap());
    user.personne = personne;
    print("Le user à ajouter ");
    print(user.toMap());

    var body = jsonEncode(user.toMap());
    var response = await http.post(Uri.parse(patientUrl), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    if (response.statusCode == 200) {
      session.set("logged", true);
      session.set("loggeduser", response.body);
    }
    var status = response.statusCode;
    return status;
  }

  // Méthode d'authentification automoatique
  Future<String> authenticate() async {
    print("authenticating");
    var session = SessionManager();
    var response = await http.post(authAdminUrl, headers: headers);
    session.set("token", response.body.toString());
    print("auth response:");
    print(response.body.toString());
    return response.body.toString();
  }

  // Méthode d'ajout de personne
  Future<Personne> addPersonne(Personne personne) async {
    String token = authToken.toString();
    var authentication = await authenticate();
    print("Auth token: $authentication");
    print("Le token");
    print("Bearer $authentication");
    personne.fonction = "PATIENT";
    var body = jsonEncode(personne.toMap());
    print(body);
    var response =
        await http.post(Uri.parse(personneUrl), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    print("the response.body");
    var body0;
    int id = 0;
    Personne newPersonne = Personne();
    if (response.body != null) {
      print("Auth token3: " + response.body);
      body0 = json.decode(response.body);
      print("Le corps de la réponse");
      print(body0);
      Personne newP = Personne.fromMap(body0);
      id = body0["id"] as int;
      print("Personne créée");
      print(newP.toMap());
      print(body0["id"]);
      id = body0["id"] as int;

      newPersonne.id = body0["id"];
      newPersonne.nom = body0["nom"];
      newPersonne.prenom = body0["prenom"];
      newPersonne.genre = body0["genre"];
      newPersonne.contact1 = body0["contact1"];
      newPersonne.dateNaissance = body0["dateNaissance"];
      newPersonne.email = body0["email"];
      newPersonne.matricule = body0["matricule"];

      print("L'id de la personne");
      print(id);
    }

    return newPersonne;
  }

  // Méthode pour l'obtention du role Patient
  Future<Role> getRole() async {
    String token = authToken.toString();
    var authentication = await authenticate();
    http.Response response = await http.get(roleUrl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    var body;
    Role role = Role();
    if (response.body != null) {
      body = json.decode(response.body);
      print("The body");
      print(body);
      role.id = body["id"] as int;
      role.titre = body["titre"];
    }
    print("Le role obtenu");
    print(role.toMap());
    return role;
  }

  // Méthode pour l'inscription
  Future<int> signup(Utilisateur user, Personne personne) async {
    try {
      Utilisateur addingUser = await findByUsername(user.userName);
      if (addingUser != null) {
        return 0;
      } else {
        print("adding the guy");
        personne.fonction = "PATIENT";
        Personne npersonne = await addPersonne(personne);
        print("Signup personne");
        print(npersonne.id);
        print(npersonne.toMap());
        int statusUser = await addUser(user, npersonne);

        return statusUser;
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      print("adding the guy");
      Personne npersonne = await addPersonne(personne);
      print("Signup personne");
      print(npersonne.id);
      print(npersonne.toMap());
      int statusUser = await addUser(user, npersonne);

      return statusUser;
    }
  }

  Future<int> updatePersonne(Personne personne, Utilisateur utilisateur) async {
    var authentication = await authenticate();
    print("Auth token: $authentication");
    print("Le token");
    print("Bearer $authentication");
    var body = jsonEncode(personne.toMap());
    print(body);
    var response = await http.put(Uri.parse(personneUrl), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    print("the response.body");
    var body0;

    if (response.body != null) {
      print("Auth: " + response.body);
      body0 = json.decode(response.body);
      print("Le corps de la réponse");
      print(body0);

      utilisateur.personne.id = body0["id"];
      utilisateur.personne.nom = body0["nom"];
      utilisateur.personne.prenom = body0["prenom"];
      utilisateur.personne.email = body0["email"];
      utilisateur.personne.matricule = body0["matricule"];
      utilisateur.personne.dateNaissance = body0["dateNaissance"];
      utilisateur.personne.contact1 = body0["contact1"];
      utilisateur.personne.genre = body0["genre"];
      utilisateur.personne.alergie = body0["alergie"];
      utilisateur.personne.groupeSanguin = body0["groupeSanguin"];
      utilisateur.personne.profession = body0["profession"];
      utilisateur.personne.sousTraitement = body0["sousTraitement"];
      utilisateur.personne.contact2 = body0["contact2"];
      utilisateur.personne.adresseResidence = body0["adresseResidence"];
      await storage.write(
          key: 'logUser', value: jsonEncode(utilisateur.toMap()));
    }
    return response.statusCode;
  }

  Utilisateur updateUtilisateur(Utilisateur user) {
    return user;
  }

  Future<Utilisateur> findByUsername(String username) async {
    String fbuUrl = "$userUrl/session/$username";
    var authentication = await authenticate();
    http.Response response = await http.get(Uri.parse(fbuUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    var body;
    Utilisateur utilisateur =
        Utilisateur.NewUtilisateur(userName: "", password: "");

    if (response.body != null) {
      body = json.decode(response.body);
      print(body);
      utilisateur.id = body["id"];
      utilisateur.userName = body["username"];
      utilisateur.password = body["password"];
      utilisateur.active = body["active"];
      utilisateur.role = Role.fromMap(body["role"]);

      utilisateur.personne.id = body["personne"]["id"];
      utilisateur.personne.nom = body["personne"]["nom"];
      utilisateur.personne.prenom = body["personne"]["prenom"];
      utilisateur.personne.email = body["personne"]["email"];
      utilisateur.personne.matricule = body["personne"]["matricule"];
      utilisateur.personne.dateNaissance = body["personne"]["dateNaissance"];
      utilisateur.personne.contact1 = body["personne"]["contact1"];
      utilisateur.personne.genre = body["personne"]["genre"];
      utilisateur.personne.alergie = body["personne"]["alergie"];
      utilisateur.personne.groupeSanguin = body["personne"]["groupeSanguin"];
      utilisateur.personne.profession = body["personne"]["profession"];
      utilisateur.personne.sousTraitement = body["personne"]["sousTraitement"];
      utilisateur.personne.contact2 = body["personne"]["contact2"];
      utilisateur.personne.adresseResidence =
          body["personne"]["adresseResidence"];

      print(utilisateur.personne);
      print("The personne id");
      print(body["personne"]["id"]);
      utilisateur = Utilisateur.fromMap(body);
    }
    print("User findbyusername:");
    print(utilisateur.id);
    return utilisateur;
  }

  Future<Utilisateur> loggedUser() async {
    String? logStringUser = await storage.read(key: "logUser");
    print(logStringUser);
    var lsu = jsonDecode(logStringUser!);
    print(lsu["id"]);
    Utilisateur logUser = Utilisateur.fromMap(lsu);
    print("LOGGED USER");
    print(logUser.personne.id);
    return logUser;
  }

  Future<int> updatePassword(String newPassword) async {
    var authentication = await authenticate();
    Utilisateur user = await loggedUser();
    user.password = newPassword;
    user.role = await getRole();
    var body = jsonEncode(user.toMap());
    http.Response response =
        await http.put(Uri.parse(userUrl), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    if (response.statusCode == 200) {
      await storage.write(key: 'logUser', value: jsonEncode(response.body));
    }
    var status = response.statusCode;
    return status;
  }

  // The logout function
  Future<void> logout() async {
    await storage.deleteAll();
  }

  List<Jour> joursFromJSON(String str) =>
      List<Jour>.from(json.decode(str).map((x) => Jour.fromMap(x)));

  // Méthode pour obtenir les jours par spécialités
  Future<List<Jour>> getJoursBySpecialite(String specialite) async {
    List<Jour> jours = <Jour>[];
    var jourUrl = "$apiUrl/api/jour/specialite/$specialite";
    var authentication = await authenticate();
    var response = await http.post(Uri.parse(jourUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });

    if (response.statusCode == 200) {
      jours = joursFromJSON(response.body);
    }
    return jours;
  }

  List<TrancheHoraire> horairesFromJSON(String str) =>
      List<TrancheHoraire>.from(
          json.decode(str).map((x) => TrancheHoraire.fromMap(x)));

  // Méthode pour obtenir les tranches horaires par jour
  Future<List<TrancheHoraire>> getTranchesHorairesByJour(int id) async {
    List<TrancheHoraire> horaires = <TrancheHoraire>[];
    var horaireUrl = "$apiUrl/api/tranche-horaire/jour/$id";
    var authentication = await authenticate();
    var response = await http.get(Uri.parse(horaireUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });

    if (response.statusCode == 200) {
      // horaires = horairesFromJSON(response.body);
      var responseJson = jsonDecode(response.body) as List;
      horaires = responseJson.map((e) => TrancheHoraire.fromMap(e)).toList();
    }

    return horaires;
  }

  Future<List<TrancheHoraire>> getTranchesHorairesByJourName(String nom) async {
    List<TrancheHoraire> horaires = <TrancheHoraire>[];
    var horaireUrl = "$apiUrl/api/tranche-horaire/journame/$nom";
    var authentication = await authenticate();
    var response = await http.get(Uri.parse(horaireUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      // horaires = horairesFromJSON(response.body);
      var responseJson = jsonDecode(response.body) as List;
      print("Response: " + responseJson.toString());
      for (var element in responseJson) {
        print(element.toString());
        TrancheHoraire h = TrancheHoraire();

        h.id = element["id"];
        h.heureFin = DateFormat("hh:mm:ss").parse(element["heureFin"]);
        h.heureDebut = DateFormat("hh:mm:ss").parse(element["heureDebut"]);
        h.jour = Jour.fromMap(element["jour"]);
        h.commentaire = element["commentaire"];
        horaires.add(h);
      }
      // horaires = responseJson.map((e) => TrancheHoraire.fromMap(e)).toList();
    }
    // print(horaires.toString());
    // horaires.forEach((element) {
    //   print(element.toString());
    //   print(element.id);
    // });

    return horaires;
  }

  Future<List<TrancheHoraire>> getTranchesHorairesByJourNameAndSpecialite(
      String jour, String specialite) async {
    List<TrancheHoraire> horaires = <TrancheHoraire>[];
    var horaireUrl = "$apiUrl/api/tranche-horaire/jourspe/$jour/$specialite";
    var authentication = await authenticate();
    var response = await http.get(Uri.parse(horaireUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      // horaires = horairesFromJSON(response.body);
      var responseJson = jsonDecode(response.body) as List;
      print("Response: " + responseJson.toString());
      for (var element in responseJson) {
        print(element.toString());
        TrancheHoraire h = TrancheHoraire();

        h.id = element["id"];
        h.heureFin = DateFormat("hh:mm:ss").parse(element["heureFin"]);
        h.heureDebut = DateFormat("hh:mm:ss").parse(element["heureDebut"]);
        h.jour = Jour.fromMap(element["jour"]);
        h.commentaire = element["commentaire"];
        horaires.add(h);
      }
    }

    return horaires;
  }

  Future<List<Slot>> getSlotsBySpecialiteAndDay(
      String jour, String specialite) async {
    List<Slot> slots = <Slot>[];
    var slotUrl = "$apiUrl/api/slot/jourspe/$jour/$specialite";
    var authentication = await authenticate();
    var response = await http.get(Uri.parse(slotUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body) as List;

      for (var element in responseJson) {
        Slot s = Slot();
        s.id = element["id"];
        s.heureDebut = element["heureDebut"];
        s.heureFin = element["heureFin"];
        slots.add(s);
      }
    }

    return slots;
  }

  Future<int> setBooking(
      RendezVous rdv, String specialite, String journame) async {
    print('Le jour: $journame');
    var bookingUrl = "$apiUrl/api/rendez-vous";
    var jourUrl = "$apiUrl/api/jour/jourspe/$journame/$specialite";
    var trancheUrl = "$apiUrl/api/tranche-horaire";
    var authentication = await authenticate();
    var res = await http.get(Uri.parse(jourUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    TrancheHoraire trancheHoraire = TrancheHoraire();
    Jour jour = Jour();
    // Personne personne = Personne();
    if (res.statusCode == 200) {
      print('JSON-DECODE Body: ');
      print(jsonDecode(res.body));
      var resJson = jsonDecode(res.body);
      print(resJson[0]);
      print(resJson);
      // trancheHoraire.heureDebut = DateTime.parse(resJson["heureDebut"]);
      // trancheHoraire.heureFin = DateTime.parse(resJson["heureFin"]);
      // trancheHoraire.commentaire = resJson["commentaire"]as String;
      // trancheHoraire.id = resJson["id"];
      // trancheHoraire.jour = Jour.fromMap(resJson["jour"]);
      // personne = trancheHoraire.jour.personne;
      jour.id = resJson[0]["id"];
      jour.date = resJson[0]["date"].toString();
      jour.commentaire = resJson[0]["commentaire"];
      jour.personne = Personne.fromMap(resJson[0]["personne"]);
      jour.personne.specialite = resJson[0]["personne"]["specialite"];
      jour.personne.id = resJson[0]["personne"]["id"];
      jour.personne.deGarde = resJson[0]["personne"]["deGarde"] ?? false;
      jour.personne.profession = resJson[0]["personne"]["profession"] ?? "";
      jour.personne.alergie = resJson[0]["personne"]["alergie"] ?? "";
      jour.personne.traitementCourant =
          resJson[0]["personne"]["traitementCourant"] ?? "";
      jour.personne.sousTraitement =
          resJson[0]["personne"]["sousTraitement"] ?? false;
      // jour.personne.groupeSanguin = resJson[0]["personne"]["groupeSanguin"] ?? "";
      jour.personne.matricule = resJson[0]["personne"]["matricule"];
      // jour.personne.dateNaissance = resJson[0]["personne"]["dateNaissance"].toString();
      jour.personne.contact1 = resJson[0]["personne"]["contact1"] ?? "";
      jour.personne.contact2 = resJson[0]["personne"]["contact2"] ?? 0;
      jour.personne.nom = resJson[0]["personne"]["nom"] ?? "";
      jour.personne.adresseResidence =
          resJson[0]["personne"]["adresseResidence"] ?? "";
      jour.personne.prenom = resJson[0]["personne"]["prenom"] ?? "";
      jour.personne.email = resJson[0]["personne"]["email"] ?? "";
      jour.personne.genre = resJson[0]["personne"]["genre"] ?? "";
      jour.personne.assure = resJson[0]["personne"]["assure"] ?? false;
      jour.personne.fonction = resJson[0]["personne"]["fonction"] ?? "";
    }
    print(trancheHoraire.jour.toString());
    rdv.jour = jour;
    print('In the back: , ${rdv.toMap()}');
    var body = jsonEncode(rdv.toMap());
    print("Body");
    print(body);
    var response = await http.post(Uri.parse(bookingUrl), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    var status = response.statusCode;
    // if (status == 200) {
    //   // Section de tranches horaires
    //   status =
    //       await sectionnerTrancheHoraire(trancheHoraire.id, rdv.heureDebut);
    // }

    return status;
  }

  Future<int> sectionnerTrancheHoraire(int id, String heure) async {
    var trancheSectionUrl = "$apiUrl/api/tranche-horaire/section/$id/$heure";
    var authentication = await authenticate();
    print('Heure début : $heure ');
    var res = await http.get(Uri.parse(trancheSectionUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });
    var status = res.statusCode;
    return status;
  }

  Future<List<RendezVous>> getRendezVous() async {
    Utilisateur loggedUtilisateur = await loggedUser();
    var idPersonne = loggedUtilisateur.personne.id;
    // print('Id de la personne : $idPersonne ');

    var bookingUrl = "$apiUrl/api/rendez-vous/patient/$idPersonne";
    var authentication = await authenticate();
    var res = await http.get(Uri.parse(bookingUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });

    List<RendezVous> rdvs = <RendezVous>[];

    if (res.statusCode == 200) {
      var resJson = jsonDecode(res.body) as List;
      print('resJson: $resJson');

      for (var element in resJson) {
        // print('Element: $element');
        RendezVous rdv = RendezVous();
        rdv.date = element["date"];
        // rdv.description = element["description"];
        rdv.heureDebut = element["heure"];
        rdv.heureFin = element["heureFin"];
        rdv.id = element["id"];
        rdv.jour.personne.specialite =
            element["jour"]["personne"]["specialite"];
        rdv.jour = Jour.fromMap(element["jour"]);

        rdvs.add(rdv);
      }
    }
    // print("Les rdvs: $rdvs");
    return rdvs;
  }

  Future<List<Personne>> getMedecins() async {
    var doctorsUrl = "$apiUrl/api/utilisateur/employes/MEDECIN";
    var authentication = await authenticate();
    var res = await http.get(Uri.parse(doctorsUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $authentication",
    });

    var body = jsonDecode(res.body) as List;

    List<Personne> medecins = <Personne>[];

    for (var element in body) {
      print('Element: ' + element.toString());
      Personne personne = Personne();
      personne.nom = element["personne"]["nom"];
      personne.prenom = element["personne"]["prenom"];
      personne.id = element["id"];
      personne.genre = element["personne"]["genre"];
      personne.specialite = element["personne"]["specialite"];
      medecins.add(personne);
    }

    return medecins;
  }
}
