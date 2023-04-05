import 'package:bill_split_app/screens/bill_creation_screen.dart';
import 'package:bill_split_app/screens/bill_details.dart';
import 'package:bill_split_app/themes/themecolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/bills.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream stream;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: darkPurple,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BillCreationPage())),
          child: const Icon(
            Icons.add_rounded,
            size: 50,
          ),
        ),
      ),
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dashboard",
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: darkPurple),
                )),
            IconButton(
              color: darkPurple,
              icon: const Icon(Icons.logout_rounded),
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/welcome', (route) => false);
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(future: Future<String>(() async {
        final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
        final db = FirebaseFirestore.instance;
        final creatorUuidRef = await db
            .collection('Users')
            .where('email', isEqualTo: currentUserEmail)
            .get();
        return creatorUuidRef.docs[0].data()['uuid'];
      }), builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return StreamBuilder(
          stream: db
              .collection('Bills')
              .where('created_by', isEqualTo: snapshot.data)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            }

            // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final bills = snapshot.data!.docs;

            return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 210 / 250,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: bills.length,
                itemBuilder: ((context, index) => BillCard(
                    bill: Bill.fromMap(bills[index].data()), index: index)));
          },
        );
      }),
    );
  }
}

class BillCard extends StatelessWidget {
  final Bill bill;
  final int index;
  const BillCard({super.key, required this.bill, required this.index});

  @override
  Widget build(BuildContext context) {
    Color textcolor = index % 1.5 == 0 ? Colors.white : darkPurple;
    return FilledButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BillDetails(
                      bill: bill,
                      tagindex: index,
                    )));
      },
      style: FilledButton.styleFrom(
        maximumSize: const Size(210, 250),
        padding: const EdgeInsets.all(0),
        backgroundColor: index % 1.5 == 0 ? darkPurple : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 250,
        width: 210,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "billtitle$index",
                child: Text(bill.title.toString(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.workSans(
                      decoration: TextDecoration.none,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: textcolor),
                    )),
              ),
              Text("Total Bill",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: textcolor),
                  )),
              Text("₹ ${bill.amount}",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: textcolor),
                  )),
              Text("Split to",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: textcolor),
                  )),
              Text(bill.participants.length.toString(),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: textcolor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
