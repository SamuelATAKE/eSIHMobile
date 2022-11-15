import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

const TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);

const TextStyle _specialiteTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);

const TextStyle _timeTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);
const TextStyle _dateTimeStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [kSecondaryColor, kTitleTextColor],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: const [0, 0.8],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const Text(
                        "RDV - Consultation",
                        style: _textStyle,
                      ),
                      Icon(
                        Icons.qr_code,
                        size: SizeConfig.defaultSize! * 4,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: Offset(-SizeConfig.defaultSize!, 0),
                        child: Image.asset(
                          "assets/images/fever.png",
                          height: 120,
                          width: 80,
                        ),
                      ),
                      const Text(
                        "09-11-2022",
                        style: _dateTimeStyle,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: const [
                        Text(
                          '12:00 - 12:30',
                          style: _timeTextStyle,
                        ),
                        Text(
                          "Chirurgie",
                          style: _specialiteTextStyle,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
