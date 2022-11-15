import 'package:esihapp/Screens/AuthScreen/LoginScreen/components/login_form.dart';
import 'package:esihapp/Screens/AuthScreen/LoginScreen/components/login_top_image.dart';
import 'package:esihapp/components/background.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const LoginScreenTopImage(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    ));
  }
}
