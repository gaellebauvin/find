import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessengerController extends StatefulWidget {
  const MessengerController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MessengerControllerState();
}

class MessengerControllerState extends State<MessengerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 70, bottom: 50, left: 20, right: 20),
        width: MediaQuery.of(context).size.width - 40,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
                margin: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  SvgPicture.asset('assets/logo.svg',
                      semanticsLabel: 'Logo Find'),
                ]))),
      ),
    );
  }
}
