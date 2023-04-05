import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String? validateName(String? value) {
  if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$").hasMatch(value!)) {
    return "Please Enter a Name";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value!.isEmpty ||
      !RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
          .hasMatch(value)) {
    return 'Please enter valid email';
  }
  return null;
}

String? validatePassword(String? value) {
  String missings = "Password must contain at least ";
  if (value!.length < 8) {
    missings += ",8 characters";
  }

  if (!RegExp("(?=.*[a-z])").hasMatch(value)) {
    missings += ",one lowercase letter";
  }
  if (!RegExp("(?=.*[A-Z])").hasMatch(value)) {
    missings += ",one uppercase letter";
  }
  if (!RegExp((r'\d')).hasMatch(value)) {
    missings += ",one digit";
  }
  if (!RegExp((r'\W')).hasMatch(value)) {
    missings += ",one symbol";
  }

  //if there is password input errors return error string
  if (missings != "Password must contain at least ") {
    return missings;
  }

  //success
  return null;
}

customErrSnackBar(String? content) => SnackBar(
      content: Text(
        content ?? "",
        style: GoogleFonts.workSans(fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.redAccent,
    );
customValidSnackBar(String content) => SnackBar(
      content: Text(
        content,
        style: GoogleFonts.workSans(fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.green.shade300,
    );
