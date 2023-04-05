import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login",
            style: GoogleFonts.workSans(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  color: Color(0xff2b2c4e)),
            )),
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/images/login_vector.svg",
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              // const SizedBo
              const LoginForm(),
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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailcontroller = TextEditingController();
  final _passwordcotroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: _emailcontroller,
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
                controller: _passwordcotroller,
                textAlignVertical: TextAlignVertical.center,
                decoration: textFieldDeco("Password", Icons.lock_rounded),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: signIn,
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

  Future<void> signIn() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailcontroller.text.trim(),
              password: _passwordcotroller.text.trim());
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', ((route) => false));
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
