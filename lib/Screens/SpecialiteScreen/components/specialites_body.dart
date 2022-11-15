import 'package:esihapp/Screens/AgendaScreen/agenda_screen.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/specialite.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/specialite_card.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';

class SpecialitesBody extends StatelessWidget {
  const SpecialitesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 2, vertical: SizeConfig.defaultSize! * 1,),
              child: GridView.builder(
                itemCount: specialites.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing:
                  SizeConfig.orientation == Orientation.landscape
                      ? SizeConfig.defaultSize! * 2
                      : 0,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => SpecialiteCard(
                  specialite: specialites[index],
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AgendaScreen(specialite: specialites[index].agenda);
                    }));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
