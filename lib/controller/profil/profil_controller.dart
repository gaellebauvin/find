import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilControllerState();
}

class ProfilControllerState extends State<ProfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  SvgPicture.asset('assets/logo.svg',
                      semanticsLabel: 'Logo Find'),
                ]))));
  }
}
