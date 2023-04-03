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
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 30, color: darkPurple),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    verifyPassController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value!)) {
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

  String? validateVerifyPassword(String? value) {
    if ((verifyPassController.text.trim() != passwordController.text.trim()) ||
        verifyPassController.text.isEmpty) {
      return "Passwords should match";
    }
    //success
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration:
                  textFieldDeco("Email", Icons.alternate_email_outlined),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              keyboardType: TextInputType.name,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDeco("Name", Icons.person_rounded),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              validator: (value) => validatePassword(value),
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
                hintStyle: GoogleFonts.workSans(),
                errorStyle: GoogleFonts.workSans(),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: darkPurple, width: 2)),
              ),
            ),
          ),
          SizedBox(
            height: 80,
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
                hintStyle: GoogleFonts.workSans(),
                errorStyle: GoogleFonts.workSans(),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: darkPurple, width: 2)),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
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
