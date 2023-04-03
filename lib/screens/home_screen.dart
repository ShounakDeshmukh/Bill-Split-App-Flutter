import 'package:bill_split_app/screens/bill_details.dart';
import 'package:bill_split_app/themes/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/bills.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Dashboard",
            style: GoogleFonts.workSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 30, color: darkPurple),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading'));
                }

                // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                final bills = snapshot.data;

                return SizedBox(
                  height: 260,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: bills!.length,
                      separatorBuilder: ((_, __) => const SizedBox(
                            width: 12,
                          )),
                      itemBuilder: ((context, index) =>
                          BillCard(bill: bills[index], index: index))),
                );
              },
              future: getbills(context),
            ),
          ],
        ),
      ),
    );
  }
}

class BillCard extends StatelessWidget {
  final Bill bill;
  final int index;
  const BillCard({super.key, required this.bill, required this.index});

  @override
  Widget build(BuildContext context) {
    Color textcolor = index % 2 == 0 ? Colors.white : darkPurple;
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
        backgroundColor: index % 2 == 0 ? darkPurple : Colors.white,
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
                          fontSize: 25,
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
                        fontSize: 16,
                        color: textcolor),
                  )),
              Text("₹ ${bill.amount}",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: textcolor),
                  )),
              Text("Split to",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: textcolor),
                  )),
              Text(bill.participants.length.toString(),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: textcolor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
