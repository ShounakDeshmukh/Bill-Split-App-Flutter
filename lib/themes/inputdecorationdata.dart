import 'package:flutter/material.dart';

import 'themecolors.dart';

InputDecoration textFieldDeco(String title, IconData icon) => InputDecoration(
      hintText: title,
      prefixIcon: Icon(
        icon,
        color: darkPurple,
      ),
      filled: true,
      border: InputBorder.none,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkPurple, width: 2)),
    );
