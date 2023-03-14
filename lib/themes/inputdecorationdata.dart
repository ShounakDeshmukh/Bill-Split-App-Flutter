import 'package:flutter/material.dart';

import 'themecolors.dart';

InputDecoration emailFieldDeco = InputDecoration(
  hintText: "Email",
  prefixIcon: Icon(
    Icons.alternate_email_rounded,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration nameFieldDeco = InputDecoration(
  hintText: "Name",
  prefixIcon: Icon(
    Icons.person,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration passFieldDeco = InputDecoration(
  hintText: "Password",
  prefixIcon: Icon(
    Icons.lock,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration passVerifyFieldDeco = InputDecoration(
  hintText: "Re-enter Password",
  prefixIcon: Icon(
    Icons.lock,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration billNameFieldDeco = InputDecoration(
  hintText: "Bill Name",
  prefixIcon: Icon(
    Icons.sell_rounded,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration amountFieldDeco = InputDecoration(
  hintText: "Amount",
  prefixIcon: Icon(
    Icons.currency_rupee_rounded,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);

InputDecoration memberFieldDeco = InputDecoration(
  hintText: "Members",
  prefixIcon: Icon(
    Icons.group,
    color: lightPurple,
  ),
  filled: true,
  border: InputBorder.none,
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: lightPurple, width: 2)),
);
