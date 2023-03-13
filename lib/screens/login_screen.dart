import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Login",
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
            children: const [
              SizedBox(
                height: 30 + 10,
              ),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: passFieldDeco,
            ),
          ),
          const SizedBox(
            height: 30,
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
