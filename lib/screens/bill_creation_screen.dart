import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../themes/inputdecorationdata.dart';
import '../themes/themecolors.dart';

class BillCreationPage extends StatefulWidget {
  const BillCreationPage({super.key});

  @override
  State<BillCreationPage> createState() => _BillCreationPageState();
}

class _BillCreationPageState extends State<BillCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: const Text("gfrghfs")),
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
  final _billnamecontroller = TextEditingController();
  final _billamountcontroller = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<TextFormField> _fields = [];
  int _fieldcount = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    _billamountcontroller.dispose();
    _billnamecontroller.dispose();
    super.dispose();
  }

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
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: textFieldDeco("Bill name", Icons.sell_rounded),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              decoration:
                  textFieldDeco("Bill Cost", Icons.currency_rupee_rounded),
            ),
          ),
          const SizedBox(
            height: 15,
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
