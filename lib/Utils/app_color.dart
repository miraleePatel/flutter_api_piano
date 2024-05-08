import 'package:flutter/material.dart';

class CustomColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color.fromRGBO(255, 66, 66, 1);

  /// Text Color

  static const Color textBtn = Color.fromRGBO(245, 245, 245, 1);
  static const Color textHere = Color.fromRGBO(208, 114, 12, 1);
  static const Color textStudioRentals = Color.fromRGBO(183, 150, 104, 1);
  static const Color textBluer = Color.fromRGBO(100, 100, 100, 1);
  static const Color textBluerMenu = Color.fromRGBO(144, 144, 144, 1);
  static const Color textDate = Color.fromRGBO(131, 131, 131, 1);

  ///  Button Color

  static const Color btn = Color.fromRGBO(134, 88, 38, 1);
  static const Color btnBorder = Color.fromRGBO(215, 201, 187, 1);
  static const Color btnCont = Color.fromRGBO(255, 253, 249, 1);
  static const Color btnGrid = Color.fromRGBO(255, 251, 244, 0.55);
  static const Color btnDropdown = Color.fromRGBO(248, 238, 218, 1);
  static const Color btnSelect = Color.fromRGBO(195, 156, 101, 1);
  static const Color btnUnselect = Color.fromRGBO(216, 216, 216, 1);
  static const Color btnSelectDateBorder = Color.fromRGBO(215, 201, 187, 1);
  static const Color btnFbBorder = Color.fromRGBO(55, 150, 233, 1);
  static const Color btnFaq = Color.fromRGBO(255, 252, 248, 1);
  static const Color btnFaqBorder = Color.fromRGBO(171, 171, 171, 1);
  static const Color btnBackMenu = Color.fromRGBO(248, 238, 218, 1);
  static const Color btnGridConBorder = Color.fromRGBO(174, 174, 174, 1);
  static const Color btnCon = Color.fromRGBO(246, 236, 224, 1);
  static const Color btnBCon = Color.fromRGBO(255, 249, 240, 1);
  static const Color cld = Color.fromRGBO(134, 88, 38, 0.08);
  static const Color cld1 = Color.fromRGBO(255, 254, 252, 1);
  static const Color cldBorder = Color.fromRGBO(215, 201, 187, 1);
  static const Color btnPcon = Color.fromRGBO(251, 244, 230, 1);
  static const Color btnPsel = Color.fromRGBO(255, 236, 210, 1);

  ///  background color

  static const Color divider = Color.fromRGBO(217, 217, 217, 1);
  static const Color bgBottem = Color.fromRGBO(142, 142, 142, 0.06);
  static const Color bgCon = Color.fromRGBO(31, 31, 31, 1);
  static const Color bgConList = Color.fromRGBO(45, 45, 45, 1);
  static const Color btnAbout = Color.fromRGBO(255, 255, 255, 1);
  static const Color paytabsBtn = Color.fromRGBO(215, 236, 255, 1);

  static const Color blue = Color.fromRGBO(92, 210, 233, 1);
  static const Color purple = Color.fromRGBO(91, 60, 177, 1);
}



// set system primary color
MaterialColor primaryColorSwatch = MaterialColor(
  CustomColor.btnSelect.value,
  const <int, Color>{
    50: CustomColor.btnSelect,
    100: CustomColor.btnSelect,
    200: CustomColor.btnSelect,
    300: CustomColor.btnSelect,
    400: CustomColor.btnSelect,
    500: CustomColor.btnSelect,
    600: CustomColor.btnSelect,
    700: CustomColor.btnSelect,
    800: CustomColor.btnSelect,
    900: CustomColor.btnSelect,
  },
);