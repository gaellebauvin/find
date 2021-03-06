import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widget/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_app_controller.dart';
import '../../model/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../messenger/messenger_controller.dart';

class SummaryController extends StatefulWidget {
  final bool find;
  final String category;
  final String address;
  final String date;
  final String hours;
  final String model;
  final String brand;
  final Color color;
  final String description;
  const SummaryController(
      {Key? key,
      required this.find,
      required this.category,
      required this.address,
      required this.date,
      required this.hours,
      required this.model,
      required this.brand,
      required this.color,
      required this.description})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => SummaryControllerState();
}

class SummaryControllerState extends State<SummaryController> {
  final db = FirebaseFirestore.instance;
  final FirebaseHelper auth = FirebaseHelper();
  String doc_ref = "";

  var userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    final bool _find = widget.find;
    final String _category = widget.category;
    final String _address = widget.address;
    final String _date = widget.date;
    final String _hours = widget.hours;
    final String _model = widget.model;
    final String _brand = widget.brand;
    final Color _color = widget.color;
    final String _description = widget.description;
    String _color_hex = _color
        .toString()
        .replaceAll(new RegExp(r"MaterialColor\(primary value: Color\("), '');
    _color_hex = _color_hex.replaceAll(new RegExp(r"\)\)"), '');
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin:
              const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 40,
          child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Header(),
                    SvgPicture.asset('assets/logo.svg',
                        semanticsLabel: 'Logo Find'),
                    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 30),
                        child: Text("R??capitulatif",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ))),
                    if (_category == "Portefeuille, CB, argent") ...[
                      SvgPicture.asset('assets/recap_money.svg',
                          semanticsLabel: 'Portefeuille, CB, argent'),
                    ] else if (_category == "Papiers d\'identite") ...[
                      SvgPicture.asset('assets/recap_identity.svg',
                          semanticsLabel: 'Papiers d\'identit??'),
                    ] else if (_category == "Sacs et bagages") ...[
                      SvgPicture.asset('assets/recap_suitcase.svg',
                          semanticsLabel: 'Sacs et bagages'),
                    ] else if (_category == "Informatique, electronique") ...[
                      SvgPicture.asset('assets/recap_computer.svg',
                          semanticsLabel: 'Informatique, ??l??ctronique'),
                    ] else if (_category == "Bijoux, accessoires") ...[
                      SvgPicture.asset('assets/recap_jewelry.svg',
                          semanticsLabel: 'Bijoux, accessoires'),
                    ] else if (_category == "Vetements") ...[
                      SvgPicture.asset('assets/recap_clothes.svg',
                          semanticsLabel: 'Vetements'),
                    ] else if (_category == "Cles") ...[
                      SvgPicture.asset('assets/recap_key.svg',
                          semanticsLabel: 'Cl??s'),
                    ] else if (_category == "Divers") ...[
                      SvgPicture.asset('assets/recap_other.svg',
                          semanticsLabel: 'Divers'),
                    ],
                    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 20),
                        child: Text(_category, textAlign: TextAlign.center)),
                    Row(children: [
                      Icon(Icons.location_on_rounded,
                          size: 40.0, color: const Color(0xFF39ADAD)),
                      Text(_address)
                    ]),
                    Row(children: [
                      Icon(Icons.access_time_rounded,
                          size: 40.0, color: const Color(0xFF39ADAD)),
                      Text("${_date} ${_hours}")
                    ]),
                    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 20),
                        child: Text("Description de l???objet",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ))),
                    Text("Mod??le: ${_model}"),
                    Text("Marque: ${_brand}"),
                    Row(children: [
                      Text("Couleur: "),
                      Container(color: _color, width: 50, height: 20)
                    ]),
                    Text("D??tails sur l\'objet: ${_description}"),
                  ])),
        ),
        SizedBox(
            width: 250,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xFF39ADAD),
                  minimumSize: const Size.fromHeight(50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                  db.collection("findForm").add({
                    'find': _find,
                    'category': _category,
                    'brand': _brand,
                    'model': _model,
                    'description': _description,
                    'date': _date,
                    'hours': _hours,
                    'address': _address,
                    'color': _color_hex,
                    'uid_user': userID
                  }).then((docRef) {
                    doc_ref = docRef.id;
                  }).then((_) => db
                          .collection('findForm')
                          .where("find", isNotEqualTo: _find)
                          .get()
                          .then((QuerySnapshot snapshot) {
                        for (var doc in snapshot.docs) {
                          if (_find == false) {
                            if (DateTime.parse(doc['date'])
                                    .compareTo(DateTime.parse(_date)) >
                                0) {
                              if (doc['uid_user'] != userID &&
                                  _category == doc['category'] &&
                                  _model == doc['model'] &&
                                  _brand == doc['brand'] &&
                                  _color_hex == doc['color']) {
                                db.collection("match").add({
                                  "user_id_find": doc['uid_user'],
                                  "user_id_lost":
                                      FirebaseAuth.instance.currentUser!.uid,
                                  "request_id_find": doc.id,
                                  "request_id_lost": doc_ref,
                                  "user_find_answer": "",
                                  "user_lost_answer": "",
                                  "status": 1
                                }).then((_) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MessengerController())));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MainAppController()));
                              }
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainAppController()));
                            }
                          } else {
                            if (DateTime.parse(doc['date'])
                                    .compareTo(DateTime.parse(_date)) >
                                0) {
                              if (doc['uid_user'] != userID &&
                                  _category == doc['category'] &&
                                  _model == doc['model'] &&
                                  _brand == doc['brand'] &&
                                  _color_hex == doc['color']) {
                                db.collection("match").add({
                                  "user_id_find":
                                      FirebaseAuth.instance.currentUser!.uid,
                                  "user_id_lost": doc['uid_user'],
                                  "request_id_find": doc_ref,
                                  "request_id_lost": doc.id,
                                  "user_find_answer": "",
                                  "user_lost_answer": "",
                                  "status": 1,
                                }).then((_) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MessengerController())));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MainAppController()));
                              }
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainAppController()));
                            }
                          }
                        }
                        ;
                      }));
                },
                child: Text('Envoyer', textAlign: TextAlign.center)))
      ]),
    ));
  }
}
