import 'package:bill_split_app/models/bills.dart';
import 'package:bill_split_app/screens/register_screen.dart';
import 'package:bill_split_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nanoid/nanoid.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

final _billnamecontroller = TextEditingController();
final _billamountcontroller = TextEditingController();
List<TextEditingController> _controllers = [];
List<TextFormField> _fields = [];
int _fieldcount = 0;
final _formKey = GlobalKey<FormState>();
final currentUser = FirebaseAuth.instance.currentUser!.uid;
final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

final db = FirebaseFirestore.instance;

Future createBill(context) async {
  final List<Participant> particpants = [];
  final String billid = nanoid(20);
  final creatorUuidRef = await db
      .collection('Users')
      .where('email', isEqualTo: currentUserEmail)
      .get();
  final String creatorUuid = creatorUuidRef.docs[0].data()['uuid'];

  final billref = FirebaseFirestore.instance.collection('Bills').doc(billid);
  final int secondsSinceEpoch =
      DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
  int _iterationCounter = 1;
  for (var _controller in _controllers) {
    final email = _controller.text.trim();
    try {
      final participantUuidRef = await db
          .collection('Users')
          .where('email', isEqualTo: _controller.text.trim())
          .get();
      if (participantUuidRef.docs.isEmpty ||
          participantUuidRef.docs.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(
            customErrSnackBar("Member $_iterationCounter doesn't exist"));
      } else {
        final String participantUuid =
            participantUuidRef.docs[0].data()['uuid'];
        final _participant = Participant(
            owedBy: participantUuid,
            toPay: double.parse(_billamountcontroller.text.trim()) /
                (_fieldcount + 1));

        particpants.add(_participant);
      }

      _iterationCounter++;
    } on Error catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customErrSnackBar(e.toString()));
    }
  }
  if (particpants.length == _fieldcount) {
    final newbill = Bill(
            id: billid,
            title: _billnamecontroller.text.trim(),
            description: "",
            amount: double.parse((_billamountcontroller.text)),
            createdBy: creatorUuid,
            createdAt: secondsSinceEpoch,
            participants: particpants)
        .toMap();

    await billref.set(newbill);

    _fieldcount = 0;
    _controllers = [];
    _fields = [];
    _billnamecontroller.clear();
    _billamountcontroller.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(customValidSnackBar("Bill Created"));
    Navigator.pushReplacementNamed(context, '/home');
  }
}

class BillCreationPage extends StatefulWidget {
  const BillCreationPage({super.key});

  @override
  State<BillCreationPage> createState() => _BillCreationPageState();
}

class _BillCreationPageState extends State<BillCreationPage> {
  @override
  void initState() {
    _fieldcount = 0;
    _controllers = [];
    _fields = [];
    _billnamecontroller.clear();
    _billamountcontroller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            createBill(context);
          }
        },
        label: const Text("Create"),
        backgroundColor: darkPurple,
      ),
      backgroundColor: lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Create Bill Split",
            style: GoogleFonts.workSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: darkPurple,
              ),
            )),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: BillCreateForm(),
        ),
      ),
    );
  }
}

class BillCreateForm extends StatefulWidget {
  const BillCreateForm({super.key});

  @override
  State<BillCreateForm> createState() => _BillCreateFormState();
}

class _BillCreateFormState extends State<BillCreateForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) return "Please Enter a Name";
              },
              controller: _billnamecontroller,
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDeco("Bill name", Icons.sell_rounded),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (!RegExp(r"([0-9]*[.])?[0-9]+").hasMatch(value!)) {
                  return "Please Enter a Valid Amount";
                }
              },
              controller: _billamountcontroller,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              decoration:
                  textFieldDeco("Bill Cost", Icons.currency_rupee_rounded),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Members",
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: darkPurple,
                        fontWeight: FontWeight.w500),
                  )),
              IconButton(
                  onPressed: () {
                    final controller = TextEditingController();

                    setState(() {
                      _fieldcount++;
                      _controllers.add(controller);
                      _fields.add(buildField(_fieldcount, controller));
                    });
                  },
                  icon: Icon(
                    Icons.add_rounded,
                    size: 30,
                    color: darkPurple,
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          _fieldcount == 0
              ? Center(
                  child: Text("No Members Added",
                      style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: darkPurple,
                            fontWeight: FontWeight.w500),
                      )),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _fields.length,
                  itemBuilder: (_, index) =>
                      buildField(index, _controllers[index])),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  TextFormField buildField(int index, TextEditingController controller) {
    return TextFormField(
        validator: (value) => validateEmail(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          suffixIconColor: darkPurple,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _fieldcount--;
                _fields.removeAt(index);

                _controllers.removeAt(index);
              });
            },
            icon: const Icon(Icons.remove_rounded),
          ),
          hintText: "Member ${index + 1}",
          prefixIcon: Icon(
            Icons.group_rounded,
            color: darkPurple,
          ),
          filled: true,
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lightPurple, width: 2)),
        ));
  }
}
