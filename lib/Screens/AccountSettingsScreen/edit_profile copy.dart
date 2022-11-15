import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Personne.dart';
import 'package:esihapp/backend/model/Utilisateur.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:esihapp/utils/green_intro_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ApiManager api = ApiManager.instance;
    final ImagePicker _picker = ImagePicker();
    // File? selectedImage;

    final nameController = TextEditingController();
    final firstnameController = TextEditingController();
    final emailController = TextEditingController();
    final telephoneController = TextEditingController();
    TextEditingController dateInput = TextEditingController();
    dateInput.text = "";

    // getImage(ImageSource source) async {
    //   final XFile? image = await _picker.pickImage(source: source);
    //   if (image != null) {
    //     selectedImage = File(image.path);
    //     // setState(() {});
    //   }
    // }
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

    Future<void> getLoggedUser() async {
      loggedUtilisateur = await api.loggedUser();
      print("The loggedUser");
      print(loggedUtilisateur.toMap());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
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
                        return 'Le nom est requis!';
                      }

                      if (input.length < 5) {
                        return 'Veuillez entrer un nom valide!';
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
                      // icon: Icon(Icons.person),
                      labelText: 'Genre',
                      items: _genderItems,
                      onChanged: (val) => print(val),
                      onSaved: (val) => print(val),
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
                        telephoneController, (String? input) {
                      if (input!.isEmpty) {
                        return 'Numéro de téléphone est requis!';
                      }

                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        'Second numéro de téléphone(facultatif)',
                        Icons.phone_outlined,
                        telephoneController, (String? input) {
                      return null;
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: dateInput,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Entrer votre date de naissance"),
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
                        telephoneController, (String? input) {
                      if (input!.isEmpty) {
                        return 'Votre adresse de résidence est requise!';
                      }
                      return null;
                    }, 4),
                    const SizedBox(
                      height: 30,
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
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
