import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

double spacerHeight = 30;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sign up",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: darkPurple,
                  ),
                )),
            Center(
              child: SvgPicture.asset(
                "assets/images/register_vector.svg",
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Center(
              child: Column(
                children: [
                  RegisterForm(),
                  SizedBox(
                    height: spacerHeight,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: emailFieldDeco,
            ),
          ),
          SizedBox(
            height: spacerHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: nameFieldDeco,
            ),
          ),
          SizedBox(
            height: spacerHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: passFieldDeco,
            ),
          ),
          SizedBox(
            height: spacerHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: passVerifyFieldDeco,
            ),
          ),
          SizedBox(
            height: spacerHeight,
          ),
          SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: lightPurple),
              child: Text("SUBMIT",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ),
          )
        ],
      ),
    );
  }
}
