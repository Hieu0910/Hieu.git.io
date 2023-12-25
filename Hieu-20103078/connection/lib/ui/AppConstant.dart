import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textfancyheader =
      GoogleFonts.poppins(fontSize: 40, color: Color.fromARGB(255, 4, 71, 126));
  static TextStyle textfancyheader_two =
      GoogleFonts.poppins(fontSize: 20, color: Color.fromARGB(255, 4, 71, 126));
  static TextStyle texterror = TextStyle(fontSize: 18, color: Colors.red[600]);
  static TextStyle textbody = TextStyle(fontSize: 18, color: Colors.black);
  static TextStyle textbodyfocus =
      TextStyle(fontSize: 22, color: const Color.fromARGB(255, 255, 233, 34));
  static TextStyle textbodywhite =
      TextStyle(fontSize: 22, color: Color.fromARGB(255, 255, 255, 255));
  static TextStyle textbodyfocuswhite =
      TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255));
  static TextStyle Textlink =
      TextStyle(fontSize: 18, color: Color.fromARGB(255, 4, 71, 126));
  static Color appbarcolor = Color.fromARGB(255, 4, 71, 126);
  static Color appbarbackground = Color.fromRGBO(149, 139, 0, 1);
  static Color backgroundcolor1 = Color.fromARGB(255, 133, 15, 7);
  static TextStyle Textlink1 =
      TextStyle(fontSize: 18, color: Color.fromARGB(255, 4, 71, 126));
  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      print("loi");
      return false;
    }
  }
}
