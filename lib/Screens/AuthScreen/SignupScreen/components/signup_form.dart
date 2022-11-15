import 'package:esihapp/Screens/AuthScreen/LoginScreen/login_screen.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/components/AlreadyHaveAnAccountCheck.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Utilisateur utilisateur =
        Utilisateur.NewUtilisateur(userName: "", password: "");
    Personne personne = Personne();
    String password = "";

    TextEditingController dateInput = TextEditingController();
    dateInput.text = "";

    ApiManager api = ApiManager.instance;
    int state = 0;
    return Form(
      key: _formKey,
      child: Column(
        children: [

          TextFormField(
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            validator: (value) =>
            (value!.isEmpty ? "Veuillez entrer votre nom" : null),
            decoration: const InputDecoration(
              hintText: "Votre nom",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            onSaved: (nom) => personne.nom = nom!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              validator: (value) =>
              (value!.isEmpty ? "Veuillez entrer votre prénom" : null),
              decoration: const InputDecoration(
                hintText: "Votre prénom",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              onSaved: (prenom) => personne.prenom = prenom!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: (value) => value!.isEmpty || (value.length < 8)
                  ? "Veuillez entrez un numéro de téléphone valide!"
                  : null,
              onSaved: (contact) {
                personne.contact1 = int.parse(contact!);
              },
              decoration: const InputDecoration(
                hintText: "Votre numéro de téléphone",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: (value) => value!.isEmpty || !value.contains(RegExp("@"))
                  ? "Veuillez entrez votre adresse mail valide!"
                  : null,
              onSaved: (email) {
                personne.email = email!;
              },
              decoration: const InputDecoration(
                hintText: "Votre adresse mail",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: dateInput,
              decoration: const InputDecoration(
                hintText: "Votre date de naissance",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.calendar_today),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);

                  personne.dateNaissance =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  dateInput.text = formattedDate;
                } else {}
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              validator: (value) =>
                  (value!.isEmpty ? "Veuillez entrer nom d'utilisateur" : null),
              decoration: const InputDecoration(
                hintText: "Votre nom d'utilisateur",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.alternate_email),
                ),
              ),
              onSaved: (username) => utilisateur.userName = username!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) => (value!.isEmpty
                  ? "Veuillez entrer votre mot de passe"
                  : null),
              decoration: const InputDecoration(
                hintText: "Votre mot de passe",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              onSaved: (password) => utilisateur.password = password!,
              onChanged: (pass) => {
                // setState((){
                //   password = pass;
                // });
                password = pass,
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) => (value!.isEmpty
                  ? "Veuillez confirmer votre mot de passe"
                  : (value != password)? "Les mots de passe ne correspondent pas" : null),
              decoration: const InputDecoration(
                hintText: "Confirmer votre mot de passe",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              onSaved: (confirmPassword) => utilisateur.password = confirmPassword!,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(utilisateur.password);
                print(utilisateur.userName);
                print(personne.email);
                personne.nom = personne.nom.toUpperCase();
                personne.prenom = personne.prenom.capitalizeWords();
                print(personne.dateNaissance);
                state = await api.signup(utilisateur, personne);
                print(state);

                if (state == 200) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                }else {
                  showTopSnackBar(
                      context, const CustomSnackBar.info(
                      message: "Ce nom d'utilisateur existe déjà!"));
                }
              }
            },
            child: Text("S'inscrire".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
