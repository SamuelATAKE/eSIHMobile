import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditPassword extends StatefulWidget {
  EditPassword({Key? key}) : super(key: key);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  ApiManager api = ApiManager.instance;

  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenTextColor,
        title: const Text('Modifier mon mot de passe'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  Text(
                    "Mettre à jour vos identifiants de connexion",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Modifier votre mot de passe",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.08),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => currentPassword = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                            } else if (value.length >= 8) {}
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Votre ancien mot de passe est requis!";
                            } else if (value.length < 8) {
                              return "Le mot de passe doit avoir au moins 8 caracatères";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Mot de passe actuel",
                            hintText: "Entrez votre mot de passe actuel",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => newPassword = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                            } else if (value.length >= 8) {}
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le nouveau mot de passe est requis!";
                            } else if (value.length < 8) {
                              return "Le mot de passe doit avoir au moins 8 caractères!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Nouveau mot de passe",
                            hintText: "Entrez votre nouveau mot de passe",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => confirmPassword = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                            } else if (value.length >= 8) {}
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez confirmer votre mot de passe !";
                            } else if (value.length < 8) {
                              return "Le mot de passe doit contenir au moins 8 caractères!";
                            } else if (newPassword != confirmPassword) {
                              return "Les mots de passe ne correspondent pas!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Confirmation du nouveau mot de passe",
                            hintText: "Confirmez votre nouveau mot de passe",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // if all are valid then go to success screen
                                // KeyboardUtil.hideKeyboard(context);
                                // Navigator.pushNamed(
                                //     context, LoginSuccessScreen.routeName);
                                print("Validate");
                                print(currentPassword);
                                print(confirmPassword);
                                Utilisateur loggedUser = await api.loggedUser();
                                print('Logged User pass in sub');
                                print(loggedUser.toMap()["password"]);
                                if (loggedUser.toMap()["password"] ==
                                    currentPassword) {
                                  int status =
                                      await api.updatePassword(newPassword!);
                                  print(status);
                                  if (status == 200) {
                                    // ignore: use_build_context_synchronously
                                    showTopSnackBar(
                                        context,
                                        const CustomSnackBar.success(
                                            message:
                                                "Mise à jour avec succès!"));

                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showTopSnackBar(
                                        context,
                                        const CustomSnackBar.error(
                                            message:
                                                "Une erreur est survenue lors de la mise à jour!"));
                                  }
                                } else {
                                  print('Not equal');
                                }
                              }
                            },
                            child: Text(
                              "Mettre à jour",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.08),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
