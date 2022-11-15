import 'package:esihapp/Screens/AuthScreen/SignupScreen/signup_screen.dart';
import 'package:esihapp/Screens/HomeScreen/home_screen.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/User.dart';
import 'package:esihapp/components/AlreadyHaveAnAccountCheck.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    User? user = User(password: '', userName: '');
    ApiManager api = ApiManager.instance;

    return Form(
      key: _formKey,
      child: Column(
        // resizeToAvoidBottomInsets: true,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) => (value!.isEmpty
                ? 'Veuillez entrer votre nom d\'utilisateur'
                : null),
            onSaved: (username) => user.userName = username!,
            decoration: const InputDecoration(
              hintText: "Votre nom d'utilisateur",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              validator: (value) =>
                  (value!.isEmpty ? 'Veuillez saisir le mot de passe' : null),
              onSaved: (password) {
                user.password = password!;
              },
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Votre mot de passe",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(user.userName.toString());
                  print("Printing");
                  print(user.password.toString());
                  _formKey.currentState!.save();
                  int res = await api.login(user);

                  print(res);

                  if (res == 200) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    showTopSnackBar(
                        context,
                        const CustomSnackBar.success(
                            message: "Connexion avec succès!"));
                  } else {
                    // ignore: use_build_context_synchronously
                    showTopSnackBar(
                        context,
                        const CustomSnackBar.info(
                            message: "Identifiants incorrects!"));
                  }
                }
              },
              child: Text(
                "Connexion".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
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
