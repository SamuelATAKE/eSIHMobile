import 'package:esihapp/Screens/AgendaScreen/agenda_screen.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/colors.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/long_card.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/short_bottom_card.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/short_top_card.dart';
import 'package:esihapp/Screens/SpecialiteScreen/components/style.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:flutter/material.dart';

class SpecialiteScreen extends StatefulWidget {
  const SpecialiteScreen({Key? key}) : super(key: key);

  @override
  _SpecialiteScreenState createState() => _SpecialiteScreenState();
}

class _SpecialiteScreenState extends State<SpecialiteScreen> {

  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   // TODO: implement initState
    //   super.initState();
    //   initializeDateFormatting(Localizations.localeOf(context).languageCode);
    // }

    return MaterialApp(
      title: 'Les spécialités',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF84AB5C),
          secondary: const Color(0xFF84AB5C),
        ),
        fontFamily: 'Gordita',
      ),
      home: const CategoryPage(),
    );

  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              padding: const EdgeInsets.only(left: 24),
              height: size.height / 4,
              width: size.width,
              decoration: const BoxDecoration(
                  color: AppColors.purple,
                  image: DecorationImage(
                      image: AssetImage('assets/images/BG-Gradient.png'),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/Back Icon.png'),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('Les services de santé', style: AppStyle.m12w)
                          ],
                        ),
                      ],
                    )),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            height: size.height - (size.height / 5),
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(34)),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    'Toutes',
                    style: AppStyle.m12b
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text('Favoris', style: AppStyle.m12bt),
                  const SizedBox(
                    width: 30,
                  ),
                  Text('Recommendés', style: AppStyle.m12bt)
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        LongCard(
                            background: AppColors.pink,
                            title: 'Cardiologie',
                            subtitle: 'La santé du coeur',
                            image: 'assets/images/cardiology.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AgendaScreen(specialite: "CARDIOLOGIE",);
                              }));
                            },
                        ),
                        ShortBottomCard(
                            background: AppColors.purple,
                            title: 'Généraliste',
                            subtitle: 'Pour des maux d\'ordre général',
                            image: 'assets/images/fever.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AgendaScreen(specialite: "GENERALISTE");
                              }));
                            },
                        ),
                        ShortTopCard(
                            background: AppColors.red,
                            title: 'Pédiatrie',
                            subtitle: 'La santé de l\'enfant',
                            image: 'assets/images/pediatrics.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const AgendaScreen(specialite: "PEDIATRIE");
                              }));
                            },
                        )
                      ],
                    ),
                    Column(
                      children: [
                        ShortTopCard(
                            background: AppColors.green,
                            title: 'Ophthalmologie',
                            subtitle: 'Vos yeux sont chers',
                            image: 'assets/images/ophthalmology.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AgendaScreen(specialite: "OPHTHALMOLOGIE");
                              }));
                            },
                        ),
                        LongCard(
                            background: AppColors.orange,
                            title: 'Maternité',
                            subtitle: 'Nous venons tous de là',
                            image: 'assets/images/maternity.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AgendaScreen(specialite: "SAGE-FEMME");
                              }));
                            },
                        ),
                        ShortBottomCard(
                            background: AppColors.green,
                            title: 'Gynécologie',
                            subtitle: '',
                            image: 'assets/images/gynecology.png',
                            onPress: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AgendaScreen(specialite: "GYNECOLOGIE");
                              }));
                            },
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}

