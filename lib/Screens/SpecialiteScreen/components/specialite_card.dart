import 'package:esihapp/Screens/SpecialiteScreen/components/specialite.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';

class SpecialiteCard extends StatelessWidget {
  final Specialite specialite;
  final Function() onPress;
  const SpecialiteCard({Key? key, required this.specialite, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;
    return GestureDetector(
      onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            color: specialite.color,
            borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
          ),
          child: Row(
            children: <Widget>[
              Expanded(child: Padding(
                padding: EdgeInsets.all(defaultSize * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Text(specialite.titre, style: TextStyle(fontSize: defaultSize * 2.2, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: defaultSize * 0.5,),
                    Text(specialite.description, style: const TextStyle(color: Colors.white54), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    const Spacer(),
                  ],
                ),
              ),
              ),
            SizedBox(height: defaultSize * 0.5,),
              AspectRatio(aspectRatio: 0.71,
                child: Image.asset(specialite.imageSrc, alignment: Alignment.center),
              )
            ],
          ),
        ),
    );
  }
}
