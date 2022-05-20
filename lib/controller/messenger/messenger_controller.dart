import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messenger_description_controller.dart';
import 'chat_detail_controller.dart';
import '../../widget/toolbar.dart';

class MessengerController extends StatefulWidget {
  const MessengerController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MessengerControllerState();
}

class MessengerControllerState extends State<MessengerController> {
  bool _find = true;
  String _match = "";
  String _user_id = "";
  Widget _buildListPseudo(QuerySnapshot snapshot, _match, _user_id) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          return Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: const Color(0xFFE4E4E6),
              ),
              child: Row(children: [
                SvgPicture.asset('assets/person_icon.svg',
                    semanticsLabel: 'Icon de l\'utilisateur'),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      child: Text(doc['pseudo']),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatDetailController(
                              match: _match, user_id: _user_id);
                        }));
                      },
                    )),
              ]));
        });
  }

  Widget _buildListFind(snapshot, _status, doc) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: const BoxDecoration(
          color: const Color(0xFFE4E4E6),
        ),
        child: Row(children: [
          SvgPicture.asset('assets/person_icon.svg',
              semanticsLabel: 'Icon de l\'utilisateur'),
          SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(children: [
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(doc['model'], textAlign: TextAlign.left)),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 10),
                      child: Text(doc['brand'], textAlign: TextAlign.left)),
                ]),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  child: Text((_status == 3)
                      ? 'Après avoir vu la description, la personne n\'a pas donné suite'
                      : 'Vous êtes en attente de réponse de votre match'),
                )
              ])),
        ]));
  }

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          final _status = doc['status'];
          final _match = doc_ref;
          final _request_id =
              (_find) ? doc['request_id_find'] : doc['request_id_lost'];
          final _user_id = (_find) ? doc['user_id_find'] : doc['user_id_lost'];
          if (doc['status'] == 1 &&
              ((_find == true && doc['user_lost_answer'] == '') ||
                  (_find == false && doc['user_find_answer'] == ''))) {
            return Container(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFE4E4E6),
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MessengerDescriptionController(
                        request_id: _request_id,
                        find: _find,
                        doc_ref: doc_ref)));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  Column(children: [
                    Text((_find)
                        ? "Quelqu'un semble avoir trouvé votre objet !"
                        : "Vous semblez avoir trouvé l'objet d\'une personne !"),
                  ])
                ],
              ),
            ));
          } else if (doc['status'] == 2 &&
              ((_find == true && doc['user_lost_answer'] != '') ||
                  (_find == false && doc['user_find_answer'] != ''))) {
            return Container(
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection("findForm")
                        .doc(_request_id)
                        .get(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) return LinearProgressIndicator();

                      final doc = snapshot.data!;
                      return Container(
                          child: _buildListFind(snapshot.data!, _status, doc));
                    }));
          } else if (doc['status'] == 3 &&
              (doc['user_lost_answer'] == doc['user_find_answer'])) {
            return Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where('uid', isEqualTo: _user_id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return LinearProgressIndicator();
                      }
                      ;
                      return Container(
                          child: _buildListPseudo(
                              snapshot.data!, _match, _user_id));
                    }));
          } else if (doc['status'] == 3) {
            return Container(
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection("findForm")
                        .doc(_request_id)
                        .get(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) return LinearProgressIndicator();

                      final doc = snapshot.data!;
                      return Container(
                          child: _buildListFind(snapshot.data!, _status, doc));
                    }));
          }
          return Container(
              child: Text(
            "Vous n'avez pas de messages",
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 70, bottom: 50),
          height: MediaQuery.of(context).size.height / 1.5,
          child: Container(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    SvgPicture.asset('assets/logo.svg',
                        semanticsLabel: 'Logo Find'),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: (_find)
                                    ? const Color(0xFF39ADAD)
                                    : Colors.black,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              setState(() {
                                _find = true;
                              });
                            },
                            child: const Text('Mes objets perdus'),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                primary: (_find)
                                    ? Colors.black
                                    : const Color(0xFF39ADAD),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              setState(() {
                                _find = false;
                              });
                            },
                            child: const Text('Mes objets trouvés'),
                          ),
                        ]),
                    if (_find) ...[
                      Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("match")
                                  .where('user_id_lost',
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return LinearProgressIndicator();
                                }
                                return Expanded(
                                    child: _buildList(snapshot.data!));
                              })),
                    ] else ...[
                      Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("match")
                                  .where('user_id_find',
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return LinearProgressIndicator();
                                return Expanded(
                                    child: _buildList(snapshot.data!));
                              })),
                    ]
                  ]))),
        ),
        bottomNavigationBar: ToolBar());
  }
}
