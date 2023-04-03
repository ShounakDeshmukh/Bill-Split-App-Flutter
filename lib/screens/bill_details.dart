import 'package:bill_split_app/models/bills.dart';
import 'package:bill_split_app/themes/themecolors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class BillDetails extends StatelessWidget {
  final Bill bill;
  final int tagindex;
  const BillDetails({super.key, required this.bill, required this.tagindex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 244, 251),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Hero(
          tag: "billtitle$tagindex",
          child: Text(bill.title.toString(),
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
                Text("₹ ${bill.amount}",
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
                    child: ListView.builder(
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
                          bill.participants[index].id,
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
                          "${bill.participants[index].paid}",
                        ),
                      ),
                      itemCount: bill.participants.length,
                    ),
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
