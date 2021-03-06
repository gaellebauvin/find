import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'profil_controller.dart';
import '../../widget/header.dart';

class ProfilEditInfosController extends StatefulWidget {
  const ProfilEditInfosController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilEditInfosControllerState();
}

class ProfilEditInfosControllerState extends State<ProfilEditInfosController> {
  final _formKey = GlobalKey<FormState>();
  String _mail = "";
  String _firstname = "";
  String _lastname = "";
  String _phone = "";
  String _pseudo = "";
  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          _firstname = doc['firstName'];
          _lastname = doc['lastName'];
          _mail = doc['email'];
          _pseudo = doc['pseudo'];
          _phone = doc['phone'].replaceAll(
              new RegExp(r'^((0[0-9]{2,4}|\+[0-9]{2}|\(\+?[0-9]{2,4}\)))'), '');
          return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              margin: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez renseigner un pseudo';
                                }
                                return null;
                              },
                              initialValue: doc['pseudo'],
                              decoration: InputDecoration(
                                labelText: "Pseudo",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: const Color(0xFF39ADAD)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _firstname = value;
                                });
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez renseigner un pr??nom';
                                }
                                return null;
                              },
                              initialValue: doc['firstName'],
                              decoration: InputDecoration(
                                labelText: "Pr??nom",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: const Color(0xFF39ADAD)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _firstname = value;
                                });
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez renseigner un nom de famille';
                                }
                                return null;
                              },
                              initialValue: doc['lastName'],
                              decoration: InputDecoration(
                                labelText: "Nom",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: const Color(0xFF39ADAD)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _lastname = value;
                                });
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: IntlPhoneField(
                              initialValue: _phone,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                labelText: 'Num??ro de t??l??phone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              initialCountryCode: 'FR',
                              onChanged: (phone) {
                                setState(() {
                                  _phone = phone.completeNumber;
                                });
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 30,
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez renseigner un email';
                                }
                                return null;
                              },
                              initialValue: doc['email'],
                              decoration: InputDecoration(
                                labelText: "Adresse mail",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _mail = value;
                                });
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: const Color(0xFF39ADAD),
                              minimumSize: const Size.fromHeight(50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(doc_ref)
                                    .update({
                                  "email": _mail,
                                  "firstName": _firstname,
                                  "lastName": _lastname,
                                  "phone": "+33${_phone}",
                                  "pseudo": _pseudo
                                });
                                Navigator.pop(context, false);
                              }
                            },
                            child: Text('Valider les modifications',
                                textAlign: TextAlign.center))),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          Container(
            margin:
                const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
            child: Header(),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SvgPicture.asset('assets/logo.svg',
                    semanticsLabel: 'Logo Find'),
              ])),
          Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    return Expanded(child: _buildList(snapshot.data!));
                  })),
        ]));
  }
}
