import 'package:esihapp/Screens/WelcomeScreen/components/loginandsignupbtn.dart';
import 'package:esihapp/Screens/WelcomeScreen/components/welcome_image.dart';
import 'package:esihapp/components/background.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Background(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const WelcomeImage(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginAndSignUpBtn(),
              ),
              Spacer(),
            ],
          ),
        ],
      )),
    ));
  }
}
