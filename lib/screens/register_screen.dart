import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

double dabbaHeight = 30;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Sign up",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: darkPurple,
              ),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: dabbaHeight + 10,
              ),
              RegisterForm()
            ],
          ),
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
            height: dabbaHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: nameFieldDeco,
            ),
          ),
          SizedBox(
            height: dabbaHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: passFieldDeco,
            ),
          ),
          SizedBox(
            height: dabbaHeight,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: passVerifyFieldDeco,
            ),
          ),
          SizedBox(
            height: dabbaHeight,
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
