import 'package:flutter/material.dart';
import '../model/firebase_helper.dart';
import '../model/find.dart';
import 'findForm/find_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/firebase_helper.dart';
import '../widget/tool_bar.dart';

class MainAppController extends StatefulWidget {
  const MainAppController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MainAppControllerState();
}

class MainAppControllerState extends State<MainAppController> {
  final FirebaseHelper auth = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 70, bottom: 50, left: 20, right: 20),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(children: [
                SizedBox(
                    child: Center(
                        child: SvgPicture.asset('assets/logo.svg',
                            semanticsLabel: 'Logo Find'))),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    auth.signOut();
                  },
                  child: Text("Deconnexion"),
                ),
                ToolBar(),
              ]))
        ]),
      ),
    );
  }
}
