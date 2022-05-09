import 'package:flutter/material.dart';
import '../model/firebase_helper.dart';
import '../model/find.dart';
import 'findForm/find_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class MainAppController {}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(children: [
  //         Container(
  //             margin: const EdgeInsets.only(
  //                 top: 70, bottom: 50, left: 20, right: 20),
  //             width: MediaQuery.of(context).size.width - 40,
  //             height: MediaQuery.of(context).size.height / 2,
  //             child: Column(children: [
  //               SizedBox(
  //                   child: Center(
  //                       child: SvgPicture.asset('assets/logo.svg',
  //                           semanticsLabel: 'Logo Find'))),
  //               SizedBox(
  //                   width: 200,
  //                   child: Center(
  //                       child: Text(
  //                     "Avez-vous trouvé un objet ou cherchez-vous un objet ?",
  //                     textAlign: TextAlign.center,
  //                     style: GoogleFonts.roboto(
  //                         fontWeight: FontWeight.w700, height: 2),
  //                   ))),
  //               SizedBox(
  //                   width: 250,
  //                   child: RaisedButton(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10)),
  //                     color: const Color(0xFF39ADAD),
  //                     padding: new EdgeInsets.only(
  //                         left: 30, right: 30, top: 13, bottom: 13),
  //                     onPressed: () {},
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           "J’ai trouvé un objet",
  //                           textAlign: TextAlign.center,
  //                           style: GoogleFonts.roboto(color: Colors.white),
  //                         ),
  //                         Spacer(),
  //                         Icon(Icons.arrow_forward_ios_outlined,
  //                             color: Colors.white),
  //                       ],
  //                     ),
  //                   )),
  //               SizedBox(
  //                   width: 250,
  //                   child: RaisedButton(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10)),
  //                     color: const Color(0xFF39ADAD),
  //                     padding: new EdgeInsets.only(
  //                         left: 30, right: 30, top: 13, bottom: 13),
  //                     onPressed: () {},
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           "J’ai perdu un objet",
  //                           textAlign: TextAlign.center,
  //                           style: GoogleFonts.roboto(color: Colors.white),
  //                         ),
  //                         Spacer(),
  //                         Icon(Icons.arrow_forward_ios_outlined,
  //                             color: Colors.white),
  //                       ],
  //                     ),
  //                   )),
  //               TextButton(
  //                 style: ButtonStyle(
  //                   foregroundColor:
  //                       MaterialStateProperty.all<Color>(Colors.blue),
  //                 ),
  //                 onPressed: () {
  //                   auth.signOut();
  //                 },
  //                 child: Text("Deconnexion"),
  //               )
  //             ]))
  //       ]),
  //     ),
  //   );
  // }
