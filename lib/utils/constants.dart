import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kSecondaryColor = Color(0xFF84AB5C);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

var kBackgroundColor = const Color(0xffF9F9F9);
var kWhiteColor = const Color(0xffffffff);
var kOrangeColor = const Color(0xffEF716B);
var kBlueColor = const Color(0xff4B7FFB);
var kYellowColor = const Color(0xffFFB167);
var kTitleTextColor = const Color(0xff1E1C61);
var kSearchBackgroundColor = const Color(0xffF2F2F2);
var kSearchTextColor = const Color(0xffC0C0C0);
var kCategoryTextColor = const Color(0xff292685);
var kGreenTextColor = const Color(0x0025D366);
var kSoftGreenTextColor = const Color(0x002C834D);

const kTextLightColor = Color(0xFF7286A5);
const kTextInfoColor = Color(0xFF202E2E);

const Color greenColor = Color(0xff2DBB54);

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black));
}

const TIME_SLOTS = {
  '9:00-9:30',
  '9:30-10:00',
  '10:00-10:30',
  '10:30-11:00',
  '11:00-11:30',
  '11:30-12:00',
  '12:00-12:30',
  '12:30-13:00',
  '13:00-13:30',
  '13:30-14:00',
  '14:00-14:30',
};

String getSpecialiteIcon(String specialite) {
  String icon = "";
  if (specialite == "GENERALITE") {
    icon = "assets/images/fever.png";
  } else if (specialite == "PEDIATRIE") {
    icon = "assets/images/pediatrics.png";
  } else if (specialite == "CARDIOLOGIE") {
    icon = "assets/images/cardiology.png";
  } else if (specialite == "OPHTHALMOLOGIE") {
    icon = "assets/images/ophthalmology.png";
  } else if (specialite == "SAGE_FEMME") {
    icon = "assets/images/maternity.png";
  } else if (specialite == "GYNECOLOGIE") {
    icon = "assets/images/gynecology.png";
  }
  return icon;
}
