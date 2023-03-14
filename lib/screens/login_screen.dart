import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            Text(
              "Login",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: darkPurple,
                ),
              ),
              textAlign: TextAlign.left,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/images/login_vector.svg",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            // const SizedBo
            Column(
              children: const [
                LoginForm(),
                SizedBox(
                  height: 30,
                ),
              ],
            )
          ],
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
