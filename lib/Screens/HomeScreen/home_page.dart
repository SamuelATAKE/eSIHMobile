import 'package:esihapp/Screens/HomeScreen/components/category_card.dart';
import 'package:esihapp/Screens/HomeScreen/components/doctor_card.dart';
import 'package:esihapp/Screens/HomeScreen/components/search_bar.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Personne> doctors = <Personne>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/menu.svg'),
                    SvgPicture.asset('assets/icons/profile.svg'),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Bienvenue à ISIS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: kTitleTextColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Spécialités',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildCategoryList(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Médecins',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildListDoctors(),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Dentiste',
            'assets/icons/dental_surgeon.png',
            kBlueColor,
          ),
          const SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Cardiologie',
            'assets/icons/heart_surgeon.png',
            kYellowColor,
          ),
          const SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Ophtamologie',
            'assets/icons/eye_specialist.png',
            kOrangeColor,
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  buildDoctorList() async {
    ApiManager api = ApiManager.instance;
    doctors = await api.getMedecins();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          FutureBuilder<dynamic>(
            future: _getDoctors(),
            builder: (context, snapshot) => ListView.builder(
              itemBuilder: (context, index) {
                return DoctorCard(
                  'Dr ${doctors[index].nom} ${doctors[index].prenom}',
                  '${doctors[index].specialite} - ISIS',
                  {
                    (doctors[index].genre == "FEMININ")
                        ? 'assets/images/doctor1.png'
                        : 'assets/images/doctor2.png'
                  },
                  {
                    (doctors[index].genre == "FEMININ")
                        ? kBlueColor
                        : kYellowColor
                  },
                );
              },
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // DoctorCard(
          //   'Dr. Joseph Cart',
          //   'Dentiste - Flower Hospitals',
          //   'assets/images/doctor2.png',
          //   kYellowColor,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // DoctorCard(
          //   'Dr. Stephanie',
          //   'Ophtamologue - Flower Hospitals',
          //   'assets/images/doctor3.png',
          //   kOrangeColor,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
        ],
      ),
    );
  }

  _getDoctors() async {
    ApiManager api = ApiManager.instance;
    doctors = await api.getMedecins();
  }

  buildListDoctors() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 280.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: FutureBuilder<dynamic>(
                future: _getDoctors(),
                builder: ((context, snapshot) => ListView.builder(
                      itemCount: doctors.length,
                      // itemBuilder: (context, index) => Text('Rendez-vous: ${rdvs[index].date}, de ${rdvs[index].heureDebut} à ${rdvs[index].heureFin}'),
                      itemBuilder: (context, index) => DoctorCard(
                        'Dr ${doctors[index].nom} ${doctors[index].prenom}',
                        '${doctors[index].specialite} - ISIS',
                        (doctors[index].genre == "FEMININ")
                            ? 'assets/images/doctor1.png'
                            : 'assets/images/doctor2.png',
                        (doctors[index].genre == "FEMININ")
                            ? Colors.blueAccent
                            : Colors.yellowAccent,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
