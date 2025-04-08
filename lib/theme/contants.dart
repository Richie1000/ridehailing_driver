import 'package:flutter/material.dart';

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const Color primaryColor = Color.fromARGB(255, 22, 17, 47);
const Color primaryClone = Color.fromARGB(169, 72, 67, 97);
const Color polylineColor = Color.fromARGB(169, 1, 23, 148);

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);
const Color searchContainer = Color.fromRGBO(0, 0, 0, 0.1);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);

const Color purpleColor = Color.fromARGB(255, 22, 17, 47);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const double searchContainerHeight = 220;

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating, //try fixed
      backgroundColor: primaryColor,
      content: Text(title),
    ),
  );
}

// const CameraPosition kGooglePlex = CameraPosition(
//   target: LatLng(5.6037, -0.1870),
//   zoom: 14.4746,
// );
