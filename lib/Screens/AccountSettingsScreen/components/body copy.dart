import 'package:esihapp/Screens/AccountSettingsScreen/components/informations.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/components/profile_menu.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/components/profile_picture.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/edit_profile.dart';
import 'package:flutter/material.dart';

class BodyAccountSettings extends StatelessWidget {
  const BodyAccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          const Information(
            image: "assets/images/profile.jpg",
            name: "Jhon Doe",
            email: "Jhondoe01@gmail.com",
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
            press: () {},
          ),
          ProfileMenu(
            text: "Centre d'aide",
            icon: "assets/icons/QuestionMark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/LogOut.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
