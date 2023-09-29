import 'package:esihapp/Screens/AccountSettingsScreen/edit_password.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/green_intro_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

const TextStyle _textStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontStyle: FontStyle.italic,
    color: Colors.white);

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiManager api = ApiManager.instance;
  final ImagePicker _picker = ImagePicker();
  // File? selectedImage;

  final nameController = TextEditingController();
  final firstnameController = TextEditingController();
  final emailController = TextEditingController();
  final telephone1Controller = TextEditingController();
  final telephone2Controller = TextEditingController();
  final adresseResidenceController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController genreInput = TextEditingController();

  Utilisateur loggedUtilisateur =
      Utilisateur.NewUtilisateur(userName: "", password: "");
  Personne personne = Personne();

  final List<Map<String, dynamic>> _genderItems = [
    {
      'value': 'MASCULIN',
      'label': 'Masculin',
      'icon': const Icon(Icons.boy),
    },
    {
      'value': 'FEMININ',
      'label': 'Féminin',
      'icon': const Icon(Icons.girl),
    },
  ];

  final List<Map<String, dynamic>> _bloodGroupItems = [
    {
      'value': 'AP',
      'label': 'A +',
    },
    {
      'value': 'AM',
      'label': 'A -',
    },
    {
      'value': 'BP',
      'label': 'B +',
    },
    {
      'value': 'BM',
      'label': 'B -',
    },
    {
      'value': 'OP',
      'label': 'O +',
    },
    {
      'value': 'OM',
      'label': 'O -',
    },
  ];

  Future<void> getLoggedUser() async {
    Utilisateur lu = await api.loggedUser();
    print(lu.toMap());
    setState(() {
      loggedUtilisateur = lu;
      nameController.text = loggedUtilisateur.personne.toMap()["nom"];
      firstnameController.text = loggedUtilisateur.personne.toMap()["prenom"];
      emailController.text = loggedUtilisateur.personne.toMap()["email"];
      telephone1Controller.text =
          loggedUtilisateur.personne.toMap()["contact1"].toString();
      telephone2Controller.text =
          loggedUtilisateur.personne.toMap()["contact2"].toString();
      adresseResidenceController.text =
          loggedUtilisateur.personne.toMap()["adresseResidence"];
      dateInput.text = loggedUtilisateur.personne.toMap()["dateNaissance"];
      genreInput.text = loggedUtilisateur.personne.toMap()["genre"]
          ? loggedUtilisateur.personne.toMap()["genre"]
          : "";
    });
    print("The loggedUser");
    print(loggedUtilisateur.toMap());
    print('L\'utilisateur, ${loggedUtilisateur.personne.nom}');
    print(loggedUtilisateur.personne.toMap()["nom"]);
  }

  @override
  void initState() {
    super.initState();
    getLoggedUser();
    print("In the initState");
    print(loggedUtilisateur.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.4,
              child: Stack(
                children: [
                  greenIntroWidgetWithoutLogos(title: 'Mon profil'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                        onTap: () {
                          // getImage(ImageSource.camera);
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Center(
              child: MaterialButton(
                color: greenColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const EditPassword();
                    }),
                  );
                },
                child: const Text(
                  'Modifier son mot de passe',
                  style: _textStyle,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                        'Nom', Icons.person_outlined, nameController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre nom est requis!';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        'Prénom(s)', Icons.person_outlined, firstnameController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre prénom est requis!';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown,
                      decoration: const InputDecoration(
                        hintText: "Genre",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(
                            Icons.person,
                            color: greenColor,
                          ),
                        ),
                      ),
                      // icon: const Icon(Icons.person, color: greenColor,),
                      // labelText: 'Genre',
                      items: _genderItems,
                      controller: genreInput,
                      onChanged: (val) => print(val),
                      onSaved: (val) => genreInput.text = val!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        'Adresse mail', Icons.email_outlined, emailController,
                        (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre adresse mail est requise!';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget('Numéro de téléphone', Icons.phone_outlined,
                        telephone1Controller, (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre numéro de téléphone est requis!';
                      }
                      if (input.length != 8) {
                        return 'Numéro de téléphone invalide!';
                      }

                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        'Second numéro de téléphone(facultatif)',
                        Icons.phone_outlined,
                        telephone2Controller, (String? input) {
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dateInput,
                      decoration: const InputDecoration(
                        hintText: "Votre date de naissance",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(
                            Icons.calendar_today,
                            color: greenColor,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          personne.dateNaissance =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          dateInput.text = formattedDate;
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget('Adresse de résidence', Icons.home_outlined,
                        adresseResidenceController, (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre adresse de résidence est requise!';
                      }
                      return null;
                    }, 4),
                    const SizedBox(
                      height: 30,
                    ),
                    greenButton("Mettre à jour", _updateInfos),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _updateInfos() async {
    // if (genreInput.text.length < 2) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("In update");
      print(nameController.text);
      print(firstnameController.text);

      Personne personne = Personne();
      personne.id = loggedUtilisateur.personne.toMap()["id"];
      personne.nom = nameController.text;
      personne.prenom = firstnameController.text;
      personne.dateNaissance = dateInput.text;
      personne.genre = genreInput.text;
      personne.adresseResidence = adresseResidenceController.text;
      personne.contact1 = int.parse(telephone1Controller.text);
      personne.contact2 = int.parse(telephone2Controller.text);
      personne.email = emailController.text;
      personne.matricule = loggedUtilisateur.personne.toMap()["matricule"];
      personne.alergie = loggedUtilisateur.personne.toMap()["alergie"];
      personne.assure = loggedUtilisateur.personne.toMap()["assure"];
      personne.deGarde = loggedUtilisateur.personne.toMap()["deGarde"];
      personne.groupeSanguin =
          loggedUtilisateur.personne.toMap()["groupeSanguin"];
      personne.fonction = loggedUtilisateur.personne.toMap()["fonction"];
      personne.traitementCourant =
          loggedUtilisateur.personne.toMap()["traitementCourant"];
      personne.sousTraitement =
          loggedUtilisateur.personne.toMap()["sousTraitement"];
      personne.profession = loggedUtilisateur.personne.toMap()["profession"];

      print("Mapping the person");
      print(personne.toMap());

      int updateStatus = await api.updatePersonne(personne, loggedUtilisateur);

      if (updateStatus == 200) {
        // ignore: use_build_context_synchronously
        showTopSnackBar(OverlayState(),
            const CustomSnackBar.success(message: "Mise à jour avec succès!"));
      } else {
        // ignore: use_build_context_synchronously
        showTopSnackBar(
            OverlayState(),
            const CustomSnackBar.info(
                message: "Erreur lors de la mise à jour!"));
      }
    }
    // } else {
    //   showTopSnackBar(
    //       context,
    //       const CustomSnackBar.info(
    //           message: "Veuillez sélectionner votre genre!"));
    // }
  }

  // ignore: non_constant_identifier_names
  TextFieldWidget(String title, IconData iconData,
      TextEditingController controller, Function validator,
      [int? maxLines]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xffA7A7A7)),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            maxLines: maxLines,
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xffA7A7A7)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: greenColor,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: greenColor,
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: _textStyle,
      ),
    );
  }
}
