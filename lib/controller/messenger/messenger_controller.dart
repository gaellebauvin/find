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
    return Scaffold(body: Column(children: [Text('page message')]));
  }
}
