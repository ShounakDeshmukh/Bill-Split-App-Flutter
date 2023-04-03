import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign up",
            style: GoogleFonts.workSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Color(0xff2b2c4e)),
            )),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/images/register_vector.svg",
                  height: 200,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const RegisterForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Center(child: Text("OR")),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: SignInButton(
                        Buttons.Google,
                        onPressed: () {},
                        text: "Sign up with Google",
                        shape: const ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        elevation: 1,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isPasswordVisible = false;
  bool isPasswordVerifyVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration:
                  textFieldDeco("Email", Icons.alternate_email_outlined),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.name,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDeco("Name", Icons.person_rounded),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: !isPasswordVisible,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                suffixIconColor: darkPurple,
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                hintText: "Enter Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: darkPurple,
                ),
                filled: true,
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: darkPurple, width: 2)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: !isPasswordVerifyVisible,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                suffixIconColor: darkPurple,
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVerifyVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded),
                  onPressed: () {
                    setState(() {
                      isPasswordVerifyVisible = !isPasswordVerifyVisible;
                    });
                  },
                ),
                hintText: "Re-Enter Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: darkPurple,
                ),
                filled: true,
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: darkPurple, width: 2)),
              ),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: darkPurple,
                  shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              child: Text("SUBMIT",
                  style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: lightGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))),
            ),
          )
        ],
      ),
    );
  }
}
