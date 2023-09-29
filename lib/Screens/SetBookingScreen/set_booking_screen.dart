// ignore_for_file: use_build_context_synchronously

import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../backend/model/RendezVous.dart';
import '../../utils/constants.dart';

const TextStyle _textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);

const TextStyle _titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.black);

const TextStyle _inputTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    fontStyle: FontStyle.normal,
    color: Color(0xffA7A7A7));

class SetBookingScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String? specialite;
  const SetBookingScreen(
      {Key? key,
      required this.selectedDate,
      required this.selectedTime,
      this.specialite})
      : super(key: key);

  @override
  State<SetBookingScreen> createState() => _SetBookingScreenState();
}

class _SetBookingScreenState extends State<SetBookingScreen> {
  final DateTime _selectedDate = DateTime.now();
  final _descriptionController = TextEditingController();
  final RendezVous rdv = RendezVous();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApiManager api = ApiManager.instance;

  Utilisateur loggedUtilisateur =
      Utilisateur.NewUtilisateur(userName: "", password: "");

  Future<void> getLoggedUser() async {
    loggedUtilisateur = await api.loggedUser();
    print("The loggedUser");
    print(loggedUtilisateur.toMap());
  }

  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    print("SuperInitState");
    super.initState();
    getLoggedUser();
    print("InitState");

    notifyHelper = NotificationHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar(context),
      body: FutureBuilder(
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Prendre un rendez-vous",
                          style: _titleTextStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: greenColor,
                        height: 10,
                        indent: 10.0,
                        endIndent: 10.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextShow(
                          "Nom et prénom(s)",
                          loggedUtilisateur.personne.toMap()["prenom"]! +
                              " " +
                              loggedUtilisateur.personne.toMap()["nom"]!),
                      const SizedBox(
                        height: 10,
                      ),
                      TextShow("Date de consultation",
                          widget.selectedDate.toString().split(" ")[0]),
                      const SizedBox(
                        height: 10,
                      ),
                      TextShow(
                          "Heure de début", widget.selectedTime.split("-")[0]),
                      const SizedBox(
                        height: 10,
                      ),
                      TextShow(
                          "Heure de fin", widget.selectedTime.split("-")[1]),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          "Motif de consultation(Veuillez décrire vos symptômes)",
                          _descriptionController, (String? input) {
                        if (input!.isEmpty) {
                          return 'Veuillez donner un motif de votre consultation';
                        }
                        if (input.length < 3) {
                          return 'Le motif doit avoir au moins 3 carcatères';
                        }
                        return null;
                      }, 4),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        minWidth: Get.width,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: greenColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            print(_descriptionController.text);

                            rdv.description = _descriptionController.text;

                            print('Heure début');
                            print(DateFormat("hh:mm:ss").parse(
                                '${widget.selectedTime.split("-")[0]}:00'));
                            print('Heure début');
                            print('${widget.selectedTime.split("-")[1]}:00');

                            rdv.date = DateFormat('yyyy-MM-dd')
                                .format(widget.selectedDate);
                            print('Selected date: ${rdv.date}');
                            // ignore: unnecessary_brace_in_string_interps
                            print('Selected date2: ${_selectedDate}');

                            rdv.heureDebut = widget.selectedTime.split("-")[0];
                            rdv.heureFin = widget.selectedTime.split("-")[1];
                            rdv.patient = loggedUtilisateur.personne;

                            print('In the form: , ${rdv.toMap()}');

                            var status = await api.setBooking(
                                rdv,
                                widget.specialite!,
                                _getJourName(DateFormat("EEEE")
                                    .format(widget.selectedDate)
                                    .toString()));

                            print('Status: $status');

                            if (status == 200) {
                              showTopSnackBar(
                                  OverlayState(),
                                  const CustomSnackBar.success(
                                      message:
                                          "Rendez-vous pris avec succès!"));

                              notifyHelper.displayNotification(
                                  title: "Rendez-vous pris!",
                                  body:
                                      "Vous avez une consultation prévue pour le ${widget.selectedDate} de ${rdv.heureDebut} à ${rdv.heureFin}");

                              Navigator.pop(context);
                            } else {
                              print("Noooooooooooo");
                              showTopSnackBar(
                                  OverlayState(),
                                  const CustomSnackBar.info(
                                      message:
                                          "Erreur lors de la prise de rendez-vous!"));
                            }
                          }
                        },
                        child: const Text(
                          "Réserver",
                          style: _textStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        future: getLoggedUser(),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kBackgroundColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.green,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpg"),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  TextFieldWidget(
      String title, TextEditingController controller, Function validator,
      [int? maxLines]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: _inputTextStyle,
        // ),
        // const SizedBox(
        //   height: 6,
        // ),
        TextFormField(
          maxLines: maxLines,
          validator: (input) => validator(input),
          controller: controller,
          style: _inputTextStyle,
          decoration: InputDecoration(hintText: title),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  TextShow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff1E1C61),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  String _getJourName(String name) {
    String journame = "";
    if (name == "Saturday") {
      journame = "Samedi";
    } else if (name == "Sunday") {
      journame = "Dimanche";
    } else if (name == "Monday") {
      journame = "Lundi";
    } else if (name == "Tuesday") {
      journame = "Mardi";
    } else if (name == "Wednesday") {
      journame = "Mercredi";
    } else if (name == "Thursday") {
      journame = "Jeudi";
    } else if (name == "Friday") {
      journame = "Vendredi";
    }
    return journame;
  }
}
