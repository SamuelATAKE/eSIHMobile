import 'package:esihapp/Screens/AccountSettingsScreen/components/body.dart';
import 'package:esihapp/Screens/AccountSettingsScreen/edit_profile.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ApiManager api = ApiManager.instance;
    Utilisateur loggedUtilisateur =
        Utilisateur.NewUtilisateur(userName: "", password: "");

    Future<void> getLoggedUser() async {
      loggedUtilisateur = await api.loggedUser();
      print("The loggedUser");
      print(loggedUtilisateur.toMap());
    }

    return Scaffold(
      // backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: BodyAccountSettings(),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 14),
      //   decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      //       boxShadow: [
      //         BoxShadow(
      //             offset: Offset(0, -15), blurRadius: 20, color: Colors.white10)
      //       ]),
      // ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kSecondaryColor,
      leading: const SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Profil"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditProfile();
                },
              ),
            );
          },
          child: Text(
            "Editer",
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize! * 1.6, //16
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
