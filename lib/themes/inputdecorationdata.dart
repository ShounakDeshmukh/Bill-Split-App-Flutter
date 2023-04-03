import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'themecolors.dart';

InputDecoration textFieldDeco(String title, IconData icon) => InputDecoration(
      hintText: title,
      prefixIcon: Icon(
        icon,
        color: darkPurple,
      ),
      hintStyle: GoogleFonts.workSans(),
      filled: true,
      errorStyle: GoogleFonts.workSans(),
      errorBorder: InputBorder.none,
      border: InputBorder.none,
      focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 3)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkPurple, width: 3)),
    );
