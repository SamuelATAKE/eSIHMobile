import 'package:esihapp/Screens/AccountSettingsScreen/edit_profile%20copy.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiManager api = ApiManager.instance;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Utilisateur loggedUtilisateur =
        Utilisateur.NewUtilisateur(userName: "", password: "");

    final currentPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();

    Future<void> getLoggedUser() async {
      loggedUtilisateur = await api.loggedUser();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                'Mise à jour du mot de passe',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Veuillez entrer votre mot de passe actuel',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: currentPassword,
                  validator: (input) {
                    if (input!.length < 6) {
                      return 'Le mot de passe doit comporter au moins 6 caractères';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Votre mot de passe actuel',
                    hintStyle: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Veuillez entrer votre nouveau mot de passe',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: newPassword,
                  validator: (input) {
                    if (input!.length < 6) {
                      return 'Le mot de passe doit comporter au moins 6 caractères';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nouveau mot de passe',
                    hintStyle: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Confirmez votre nouveau mot de passe',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: confirmPassword,
                  validator: (input) {
                    if (input!.length < 6) {
                      return 'Le mot de passe doit comporter au moins 6 caractères';
                    }
                    if (confirmPassword != newPassword) {
                      return 'Les mots de passe ne correspondent pas!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Confirmez votre mot de passe',
                    hintStyle: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    print(confirmPassword);
                    print(currentPassword);
                    // Utilisateur loggedUser = await api.loggedUser();
                    // if (loggedUser.toMap()["password"] ==
                    //     currentPassword.text) {
                    //   int status = await api.updatePassword(newPassword.text);
                    //   if (status == 200) {
                    //     // ignore: use_build_context_synchronously
                    //     showTopSnackBar(
                    //         context,
                    //         const CustomSnackBar.success(
                    //             message: "Mise à jour avec succès!"));

                    //     // ignore: use_build_context_synchronously
                    //     Navigator.pop(context);
                    //   } else {
                    //     // ignore: use_build_context_synchronously
                    //     showTopSnackBar(
                    //         context,
                    //         const CustomSnackBar.error(
                    //             message:
                    //                 "Une erreur est survenue lors de la mise à jour!"));
                    //   }
                    // }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kPrimaryColor),
                  child: Text(
                    "Réinitialiser le mot de passe",
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kSecondaryColor),
                    child: const Text(
                      "Annuler",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
