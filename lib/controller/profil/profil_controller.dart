import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profil_edit_infos_controller.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilControllerState();
}

class ProfilControllerState extends State<ProfilController> {
  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          return Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(children: [
                    SvgPicture.asset('assets/photo_profil.svg',
                        width: 100, semanticsLabel: 'Photo du profil'),
                    Spacer(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc['firstName']),
                          Text(doc['lastName']),
                        ])
                  ])),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text("Mail :",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ))),
              Text(doc['email']),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text("Numéro de téléphone :",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ))),
              Text(doc['phone']),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilEditInfosController()));
                      },
                      child: Text('Modifier mes informations',
                          textAlign: TextAlign.center))),
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
                      onPressed: () {},
                      child: Text('Modifier mon mot de passe',
                          textAlign: TextAlign.center)))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SvgPicture.asset('assets/logo.svg',
                    semanticsLabel: 'Logo Find'),
              ])),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              print(FirebaseAuth.instance.currentUser?.uid);
            },
            child: Text("Deconnexion"),
          ),
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
                  }))
        ]));
  }
}
