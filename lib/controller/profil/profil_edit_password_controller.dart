import 'package:flutter/material.dart';
import '../../model/firebase_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'profil_controller.dart';
import '../../widget/header.dart';

class ProfilEditPasswordController extends StatefulWidget {
  const ProfilEditPasswordController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProfilEditPasswordControllerState();
}

class ProfilEditPasswordControllerState
    extends State<ProfilEditPasswordController> {
  String _pwd = "";
  final FirebaseHelper auth = FirebaseHelper();
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 60),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Header(),
              Container(
                  margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    SvgPicture.asset('assets/logo.svg',
                        semanticsLabel: 'Logo Find'),
                  ])),
              Text('Nouveau mot de passe'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _pwd = value;
                  });
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
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
                            auth.changePassword(_pwd);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilController()));
                          },
                          child: Text('Valider mon nouveau mot de passe',
                              textAlign: TextAlign.center))))
            ])));
  }
}
