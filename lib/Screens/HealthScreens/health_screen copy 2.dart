import 'package:esihapp/Screens/HealthScreens/BookingScreen/components/BookingCard.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/RendezVous.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  List<RendezVous> rdvs = <RendezVous>[];

  ApiManager api = ApiManager.instance;

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // api = ApiManager.instance;
    _getRdvs();
    print('Rdv in initstate: $rdvs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 202, 196, 196),
        appBar: buildAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const Gap(20),
            FittedBox(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFFF4F6FD),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 185,
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50)),
                            color: Colors.white),
                        child: const Center(
                          child: Text("Consultations"),
                        ),
                      ),
                      Container(
                        width: 186,
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(50)),
                            color: Color.fromARGB(31, 145, 189, 42)),
                        child: const Center(
                          child: Text("Ordonnances"),
                        ),
                      ),
                    ],
                  )),
            ),
            const Gap(20),
            rdvs.isNotEmpty
                ? SafeArea(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GridView.builder(
                            itemCount: rdvs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.65,
                            ),
                            itemBuilder: (context, index) => BookingCard(
                              rdv: rdvs[index],
                              specialite: rdvs[index].jour.personne.specialite,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
                : const Text("Vous n'avez pas de consultation"),
          ],
        ));
  }

  _getRdvs() async {
    List<RendezVous> patientrdvs = await api.getRendezVous();
    setState(() {
      rdvs = patientrdvs;
    });
  }
}

AppBar buildAppBar() {
  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
    // On Android by default its false
    centerTitle: true,
    title: Image.asset("assets/images/logo1.png"),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/search.svg"),
        onPressed: () {},
      ),
      // ignore: prefer_const_constructors
      SizedBox(
        // It means 5 because by out defaultSize = 10
        width: 5,
      )
    ],
  );
}
