import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 244, 251),
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Dashboard",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Color(0xff2b2c4e)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: ElevatedButton(
                      onPressed: (() {}),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(100, 250),
                          backgroundColor: const Color(0xff5b42cf),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Icon(
                                Icons.add_circle_outline_rounded,
                                size: 30,
                              ),
                            ),
                            const Text(
                              "Add bill",
                              style: TextStyle(fontSize: 23),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Cardbill(),
                  const Cardbill(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadiusDirectional.vertical(top: Radius.circular(40)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 24),
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text("Friends",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  fontSize: 28, color: Color(0xff2b2c4e)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Cardbill extends StatelessWidget {
  const Cardbill({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 220,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        color: const Color(0xffb9e5ff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
