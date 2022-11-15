import 'package:esihapp/backend/model/RendezVous.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class BookingCard extends StatelessWidget {
  final RendezVous rdv;
  final String? specialite;
  const BookingCard({super.key, required this.rdv, this.specialite});

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize! * 2,
              vertical: SizeConfig.screenHeight! * 2),
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
                        getSpecialiteIcon(specialite!),
                        height: 120,
                        width: 80,
                      ),
                    ),
                    Text(
                      rdv.date,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
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
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white70),
                      ),
                      Text(
                        rdv.jour.personne.specialite,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white70),
                      )
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
