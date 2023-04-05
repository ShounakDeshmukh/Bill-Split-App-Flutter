import 'package:bill_split_app/models/bills.dart';
import 'package:bill_split_app/themes/themecolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class BillDetails extends StatefulWidget {
  final Bill bill;
  final int tagindex;
  const BillDetails({super.key, required this.bill, required this.tagindex});

  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Hero(
          tag: "billtitle${widget.tagindex}",
          child: Text(widget.bill.title.toString(),
              style: GoogleFonts.workSans(
                decoration: TextDecoration.none,
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: darkPurple),
              )),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Bill",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: darkPurple),
                    )),
                Text("₹ ${widget.bill.amount}",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 60,
                          color: darkPurple),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadiusDirectional.vertical(top: Radius.circular(40)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 25),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 15, 0, 10),
                    child: Text("Split with",
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              fontSize: 28,
                              color: darkPurple,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Flexible(
                    child: FutureBuilder(future: Future<List<String>>(() async {
                      final List<String> participantNames = [];
                      final db = FirebaseFirestore.instance;
                      for (var participant in widget.bill.participants) {
                        final partricipantNameRef = await db
                            .collection('Users')
                            .where('uuid', isEqualTo: participant.owedBy)
                            .get();
                        if (partricipantNameRef.docs.isEmpty ||
                            partricipantNameRef.docs.length > 1) {
                        } else {
                          final String participantName =
                              partricipantNameRef.docs[0].data()['name'];

                          participantNames.add(participantName);
                        }
                      }
                      return participantNames;
                    }), builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      return ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: darkPurple,
                            child: Text("${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          title: Text(
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.workSans(
                              textStyle:
                                  TextStyle(fontSize: 20, color: darkPurple),
                            ),
                            snapshot.data![index],
                          ),
                          trailing: Text(
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: darkPurple,
                                  fontWeight: FontWeight.w600),
                            ),
                            "${widget.bill.participants[index].toPay}",
                          ),
                        ),
                        itemCount: widget.bill.participants.length,
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
