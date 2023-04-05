import 'package:bill_split_app/models/billuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanoid/nanoid.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';
import 'package:uuid/uuid.dart';

import '../utils.dart';

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
              const SizedBox(
                height: 30,
              ),
              const RegisterForm(),
              const SizedBox(
                height: 30,
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

  String? validateVerifyPassword(String? value) {
    if ((verifyPassController.text.trim() != passwordController.text.trim())) {
      return "Passwords should match";
    }
    if (verifyPassController.text.isEmpty) {
      return "Please enter verify password";
    }
    //success
    return null;
  }

  Future createUser(context) async {
    final String docid = nanoid(20);
    final userRef = FirebaseFirestore.instance.collection('Users').doc(docid);
    final uuid = const Uuid().v1();
    final user = BillUser(
            userId: docid,
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            uuid: uuid)
        .toMap();

    userRef.set(user);
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/home', ((route) => false));
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
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration:
                  textFieldDeco("Email", Icons.alternate_email_outlined),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              controller: nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => validateName(value),
              keyboardType: TextInputType.name,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDeco("Name", Icons.person_rounded),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: verifyPassController,
              validator: (value) => validateVerifyPassword(value),
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
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: lightPurple,
                            ),
                          ));
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                    ScaffoldMessenger.of(context)
                        .showSnackBar(customValidSnackBar("User Created"));
                    createUser(context);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(customErrSnackBar(e.message));
                    Navigator.pop(context);
                  }
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
