import 'package:flutter/material.dart';
import '../model/firebase_helper.dart';
import 'findForm/find_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'log_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/toolbar.dart';

class MainAppController extends StatefulWidget {
  const MainAppController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MainAppControllerState();
}

class MainAppControllerState extends State<MainAppController> {
  final FirebaseHelper auth = FirebaseHelper();
  final db = FirebaseFirestore.instance;

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          return Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 15, right: 15),
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: const Color(0xFFE4E4E6),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(doc["find"] ? "Objet trouvé" : "Objet perdu",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  Text(doc['category']),
                  Text(doc['address']),
                  Text('Le ${doc['date']} à ${doc['hours']}'),
                  RaisedButton(
                      padding: const EdgeInsets.all(0.0),
                      color: const Color(0xFFE4E4E6),
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      child: Text(
                        'Supprimer la demande',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('findForm')
                            .doc(doc_ref)
                            .delete();
                      }),
                ]),
                Spacer(),
                if (doc['category'] == "Portefeuille, CB, argent") ...[
                  SvgPicture.asset('assets/argent.svg',
                      width: 140, semanticsLabel: 'Portefeuille, CB, argent'),
                ] else if (doc['category'] == "Papiers d\'identite") ...[
                  SvgPicture.asset('assets/identity.svg',
                      width: 140, semanticsLabel: 'Papiers d\'identité'),
                ] else if (doc['category'] == "Sacs et bagages") ...[
                  SvgPicture.asset('assets/sacs.svg',
                      width: 140, semanticsLabel: 'Sacs et bagages'),
                ] else if (doc['category'] == "Informatique, electronique") ...[
                  SvgPicture.asset('assets/informatique.svg',
                      width: 140, semanticsLabel: 'Informatique, éléctronique'),
                ] else if (doc['category'] == "Bijoux, accessoires") ...[
                  SvgPicture.asset('assets/accessoires.svg',
                      width: 140, semanticsLabel: 'Bijoux, accessoires'),
                ] else if (doc['category'] == "Vetements") ...[
                  SvgPicture.asset('assets/vetements.svg',
                      width: 140, semanticsLabel: 'Vetements'),
                ] else if (doc['category'] == "Cles") ...[
                  SvgPicture.asset('assets/key.svg',
                      width: 140, semanticsLabel: 'Clés'),
                ] else if (doc['category'] == "Divers") ...[
                  SvgPicture.asset('assets/other.svg',
                      width: 140, semanticsLabel: 'Divers'),
                ],
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
              width: MediaQuery.of(context).size.width - 40,
              child: Column(children: [
                SizedBox(
                    child: Center(
                        child: SvgPicture.asset('assets/logo.svg',
                            semanticsLabel: 'Logo Find'))),
              ]),
            ),
          ]),
          Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("findForm")
                      .where("uid_user",
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    return Expanded(child: _buildList(snapshot.data!));
                  })),
        ]),
        bottomNavigationBar: ToolBar());
  }
}
