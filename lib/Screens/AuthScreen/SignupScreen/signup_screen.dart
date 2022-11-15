import 'package:esihapp/Screens/AuthScreen/SignupScreen/components/signup_form.dart';
import 'package:esihapp/Screens/AuthScreen/SignupScreen/components/signupscreentopimage.dart';
import 'package:esihapp/components/background.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SignUpScreenTopImage(),
                Row(
                  children: const [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: SignUpForm(),
                    ),
                    Spacer(),
                  ],
                ),
                // const SocalSignUp()
              ],
            ),
          )),
    );
  }
}
