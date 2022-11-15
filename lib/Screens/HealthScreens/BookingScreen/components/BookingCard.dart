import 'package:esihapp/backend/model/RendezVous.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

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

class BookingCard extends StatelessWidget {
  final RendezVous rdv;
  final String? specialite;
  const BookingCard({super.key, required this.rdv, this.specialite});

  @override
  Widget build(BuildContext context) {
    // print('The rdv date - : ${rdv.date}');
    // print('The rdv heureDebut - : ${rdv.heureDebut}');
    // print('The rdv heureFin - : ${rdv.heureFin}');
    // print('--------------------------------------------------------');
    return AspectRatio(
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const Text("Rendez-vous"),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Text(
                      "RDV - Consultation",
                      style: _textStyle,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.qr_code,
                      size: SizeConfig.defaultSize! * 4,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: Image.asset(
                        specialite!.isNotEmpty
                            ? getSpecialiteIcon(specialite!)
                            : "assets/images/fever.png",
                        height: 120,
                        width: 80,
                      ),
                    ),
                    Text(
                      rdv.date,
                      style: _dateTimeStyle,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${rdv.heureDebut} - ${rdv.heureFin}',
                        style: _timeTextStyle,
                      ),
                      Text(
                        rdv.jour.personne.specialite.isNotEmpty
                            ? rdv.jour.personne.specialite
                            : "specialite",
                        style: _specialiteTextStyle,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
