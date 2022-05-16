import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfilEditInfosController extends StatefulWidget {
  const ProfilEditInfosController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilEditInfosControllerState();
}

class ProfilEditInfosControllerState extends State<ProfilEditInfosController> {
  // Widget _buildList(QuerySnapshot snapshot) {
  //   return ListView.builder(
  //       itemCount: snapshot.docs.length,
  //       itemBuilder: (context, index) {
  //         String doc = snapshot.docs[index];
  //         String doc_ref = snapshot.docs[index].reference.id;
  //         // _phone = doc['phone']
  //         //     .replaceAll(new RegExp(r'^(\(?(0|\+|)[0-9]{2,4}\)?) ?'), '');
  //         return Container(
  //             height: MediaQuery.of(context).size.height / 1.5,
  //             margin: const EdgeInsets.only(
  //                 top: 10, bottom: 10, left: 50, right: 50),
  //             padding: const EdgeInsets.only(
  //                 top: 10, bottom: 10, left: 10, right: 10),
  //             child: Column(children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Padding(
  //                       padding: const EdgeInsets.only(
  //                         top: 10,
  //                         bottom: 10,
  //                       ),
  //                       child: TextFormField(
  //                         initialValue: doc['firstName'],
  //                         decoration: InputDecoration(
  //                           labelText: "Prénom",
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 color: const Color(0xFF39ADAD)),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         onChanged: (String value) {
  //                           setState(() {
  //                             // _firstname = value;
  //                           });
  //                         },
  //                       )),
  //                   Padding(
  //                       padding: const EdgeInsets.only(
  //                         top: 10,
  //                         bottom: 10,
  //                       ),
  //                       child: TextFormField(
  //                         initialValue: doc['lastName'],
  //                         decoration: InputDecoration(
  //                           labelText: "Nom",
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 color: const Color(0xFF39ADAD)),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         onChanged: (String value) {
  //                           setState(() {
  //                             // _lastname = value;
  //                           });
  //                         },
  //                       )),
  //                   Padding(
  //                       padding: const EdgeInsets.only(
  //                         top: 10,
  //                         bottom: 10,
  //                       ),
  //                       child: IntlPhoneField(
  //                         initialValue: doc['phone'],
  //                         decoration: InputDecoration(
  //                           labelText: 'Numéro de téléphone*',
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         initialCountryCode: 'FR',
  //                         onChanged: (phone) {
  //                           setState(() {
  //                             // _phone = phone.completeNumber;
  //                           });
  //                         },
  //                       )),
  //                   Padding(
  //                       padding: const EdgeInsets.only(
  //                         top: 10,
  //                         bottom: 10,
  //                       ),
  //                       child: TextFormField(
  //                         initialValue: doc['email'],
  //                         decoration: InputDecoration(
  //                           hintText: "Adresse mail",
  //                           // errorText: 'Le prénom n\'est pas valide',
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                         onChanged: (String value) {
  //                           setState(() {
  //                             // _mail = value;
  //                           });
  //                         },
  //                       )),
  //                 ],
  //               ),
  //               SizedBox(
  //                   child: OutlinedButton(
  //                       style: OutlinedButton.styleFrom(
  //                         primary: Colors.white,
  //                         backgroundColor: const Color(0xFF39ADAD),
  //                         minimumSize: const Size.fromHeight(50),
  //                         shape: const RoundedRectangleBorder(
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(10))),
  //                       ),
  //                       onPressed: () {
  //                         // FirebaseFirestore.instance
  //                         //     .collection("Users")
  //                         //     .where("uid",
  //                         //         isEqualTo:
  //                         //             FirebaseAuth.instance.currentUser?.uid)
  //                         //     .update({
  //                         //   "email": _mail,
  //                         //   "firstName": _firstname,
  //                         //   "lastName": _lastname,
  //                         //   "phone": _phone
  //                         // });
  //                       },
  //                       child: Text('Valider les modifications',
  //                           textAlign: TextAlign.center))),
  //             ]));
  //       });
  // }

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
          // Container(
          //     child: StreamBuilder<QuerySnapshot>(
          //         stream: FirebaseFirestore.instance
          //             .collection("Users")
          //             .where("uid",
          //                 isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          //             .snapshots(),
          //         builder: (context, snapshot) {
          //           if (!snapshot.hasData) return LinearProgressIndicator();
          //           return Expanded(child: _buildList(snapshot.data!));
          //         }))
        ]));
  }
}