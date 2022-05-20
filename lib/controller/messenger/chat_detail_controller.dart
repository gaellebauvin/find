import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'messenger_description_controller.dart';

class ChatDetailController extends StatefulWidget {
  final String match;
  final String user_id;
  const ChatDetailController(
      {Key? key, required this.match, required this.user_id})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ChatDetailControllerState();
}

class ChatDetailControllerState extends State<ChatDetailController> {
  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.docs.length,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final doc_ref = snapshot.docs[index].reference.id;
          return Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment:
                    (doc['idTo'] == FirebaseAuth.instance.currentUser?.uid
                        ? Alignment.topLeft
                        : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        (doc['idTo'] == FirebaseAuth.instance.currentUser?.uid
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    doc['content'],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ));
        });
  }

  String _message = "";

  @override
  Widget build(BuildContext context) {
    final String _match = widget.match;
    final String _user_id = widget.user_id;
    return Scaffold(
        body: Container(
            margin:
                const EdgeInsets.only(top: 70, bottom: 50, left: 20, right: 20),
            child: Column(children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 30.0),
                      onPressed: () {
                        Navigator.pop(context, false);
                      })),
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Messages')
                          .where('match', isEqualTo: _match)
                          .orderBy('content')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return LinearProgressIndicator();
                        return Expanded(child: _buildList(snapshot.data!));
                      })),
              Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 10, left: 10),
                        child: TextField(
                          decoration: InputDecoration(
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
                              _message = value;
                            });
                          },
                        ))),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('Messages').add({
                      'match': _match,
                      'idFrom': FirebaseAuth.instance.currentUser?.uid,
                      'idTo': _user_id,
                      'content': _message,
                      'timestamp': new DateTime.now()
                    });
                  },
                ),
              ])
            ])));
  }
}
