import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/themecolors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/welcome_vector.svg",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: darkPurple),
                    ),
                    "Spliterr",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    maxLines: 1,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                          color: darkPurple),
                    ),
                    "Splitting Bills made easy",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              shape: const ContinuousRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              side: BorderSide(width: 1.5, color: darkPurple)),
                          child: Text(
                            maxLines: 1,
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: darkPurple),
                            ),
                            "LOGIN",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            elevation: 0,
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: darkPurple),
                        child: Text(
                          maxLines: 1,
                          style: GoogleFonts.workSans(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: lightGrey),
                          ),
                          "SIGNUP",
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
