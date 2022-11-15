import 'dart:developer';
import 'dart:math';

import 'package:esihapp/Screens/AccountSettingsScreen/components/informations.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/components/profile_menu.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/edit_profile.dart';
import 'package:esihapp/Screens/AuthScreen/LoginScreen/login_screen.dart';
import 'package:esihapp/Screens/HealthScreens/BookingScreen/booking_screen.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:flutter/material.dart';

class BodyAccountSettings extends StatefulWidget {
  BodyAccountSettings({Key? key}) : super(key: key);

  @override
  _BodyAccountSettingsState createState() => _BodyAccountSettingsState();
}

class _BodyAccountSettingsState extends State<BodyAccountSettings> {
  ApiManager api = ApiManager.instance;
  Utilisateur loggedUtilisateur =
      Utilisateur.NewUtilisateur(userName: "", password: "");

  String userName = "";
  String nom = "";
  String email = "";
  String prenom = "";

  Future<void> getLoggedUser() async {
    Utilisateur lu = await api.loggedUser();
    print(lu.toMap());
    setState(() {
      loggedUtilisateur = lu;
    });
    print("The loggedUser");
    print(loggedUtilisateur.toMap());
    print('L\'utilisateur, $loggedUtilisateur.personne.nom');
    print(loggedUtilisateur.personne.toMap()["nom"]);
  }

  @override
  void initState() {
    // super.initState();
    getLoggedUser();
    print("In the body initState");
    print(loggedUtilisateur.toMap());
    nom = loggedUtilisateur.personne.toMap()["nom"];
    prenom = loggedUtilisateur.personne.toMap()["prenom"];
    email = loggedUtilisateur.personne.toMap()["email"];
    userName = loggedUtilisateur.toMap()["username"];
    print('Le nom');
    print(loggedUtilisateur.personne.toMap()["nom"]);
    print('Le prénom');
    print(loggedUtilisateur.personne.toMap()["prenom"]);
    print('Le mail');
    print(loggedUtilisateur.personne.toMap()["email"]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Information(
            image: "assets/images/profile.jpg",
            name: loggedUtilisateur.personne.toMap()["prenom"]! +
                " " +
                loggedUtilisateur.personne.toMap()["nom"]!,
            email: loggedUtilisateur.personne.toMap()["email"]!,
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Mon compte",
            icon: "assets/icons/UserIcon.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditProfile();
                  },
                ),
              )
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Paramètres",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BookingScreen();
                  },
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Centre d'aide",
            icon: "assets/icons/QuestionMark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/LogOut.svg",
            press: () async {
              await api.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
