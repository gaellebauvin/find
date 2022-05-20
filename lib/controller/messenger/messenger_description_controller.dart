import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messenger_controller.dart';

class MessengerDescriptionController extends StatefulWidget {
  final String request_id;
  final bool find;
  final String doc_ref;
  const MessengerDescriptionController(
      {Key? key,
      required this.request_id,
      required this.find,
      required this.doc_ref})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => MessengerDescriptionControllerState();
}

class MessengerDescriptionControllerState
    extends State<MessengerDescriptionController> {
  @override
  Widget build(BuildContext context) {
    final String _request_id = widget.request_id;
    final bool _find = widget.find;
    final String _doc_ref = widget.doc_ref;
    return Scaffold(
        body: Container(
            margin:
                const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo Find'),
              Text('Est-ce la description de votre objet ?'),
              Container(
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('findForm')
                          .doc(_request_id)
                          .get(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          var doc = snapshot.data!.data();
                          return Expanded(
                              child: Container(
                                  child: Column(children: [
                            Text(doc!['description']),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: const Color(0xFF39ADAD),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  if (_find == true) {
                                    final collection = FirebaseFirestore
                                        .instance
                                        .collection('match')
                                        .doc(_doc_ref)
                                        .get();
                                    if (snapshot.hasData) {
                                      doc = snapshot.data!.data();
                                      if (doc?['status'] == 2) {
                                        FirebaseFirestore.instance
                                            .collection('match')
                                            .doc(_doc_ref)
                                            .update({
                                          'user_lost_answer': 'yes',
                                          'status': 3
                                        }).then((_) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessengerController())));
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('match')
                                            .doc(_doc_ref)
                                            .update({
                                          'user_lost_answer': 'yes',
                                          'status': 2
                                        }).then((_) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessengerController())));
                                      }
                                    }
                                  } else {
                                    if (doc?['status'] == 2) {
                                      FirebaseFirestore.instance
                                          .collection('match')
                                          .doc(_doc_ref)
                                          .update({
                                        'user_find_answer': 'yes',
                                        'status': 3
                                      }).then((_) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessengerController())));
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('match')
                                          .doc(_doc_ref)
                                          .update({
                                        'user_find_answer': 'yes',
                                        'status': 2
                                      }).then((_) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessengerController())));
                                    }
                                  }
                                },
                                child: Text(
                                    "Oui, cela correspond à la description de mon objet",
                                    textAlign: TextAlign.center)),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: const Color(0xFF39ADAD),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  if (_find == true) {
                                    final collection = FirebaseFirestore
                                        .instance
                                        .collection('match')
                                        .doc(_doc_ref)
                                        .get();
                                    if (snapshot.hasData) {
                                      doc = snapshot.data!.data();
                                      if (doc?['status'] == 2) {
                                        FirebaseFirestore.instance
                                            .collection('match')
                                            .doc(_doc_ref)
                                            .update({
                                          'user_lost_answer': 'no',
                                          'status': 3
                                        }).then((_) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessengerController())));
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('match')
                                            .doc(_doc_ref)
                                            .update({
                                          'user_lost_answer': 'no',
                                          'status': 2
                                        }).then((_) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        MessengerController())));
                                      }
                                    }
                                  } else {
                                    if (doc?['status'] == 2) {
                                      FirebaseFirestore.instance
                                          .collection('match')
                                          .doc(_doc_ref)
                                          .update({
                                        'user_find_answer': 'no',
                                        'status': 3
                                      }).then((_) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessengerController())));
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('match')
                                          .doc(_doc_ref)
                                          .update({
                                        'user_find_answer': 'no',
                                        'status': 2
                                      }).then((_) => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessengerController())));
                                    }
                                  }
                                },
                                child: Text(
                                    "Non cela ne correspond pas à la description de mon objet",
                                    textAlign: TextAlign.center))
                          ])));
                        }

                        return LinearProgressIndicator();
                      })),
            ])));
  }
}
