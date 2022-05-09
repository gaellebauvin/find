import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/firebase_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogController extends StatefulWidget {
  const LogController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogControllerState();
}

class LogControllerState extends State<LogController> {
  bool _log = true;
  String _mail = '';
  String _pwd = '';
  String _firstname = '';
  String _lastname = "";
  String _phone = "";
  String _civilite = "";
  String _errorMessage = '';
  String dropdownValue = 'Femme';
  final FirebaseHelper auth = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 70, bottom: 50, left: 20, right: 20),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 1.5,
              child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: textfields(),
                  )),
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
                      _handleLog();
                    },
                    child: Text((_log) ? "Connexion" : "Inscription",
                        textAlign: TextAlign.center))),
            SizedBox(
                width: 200,
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _log = !_log;
                      });
                    },
                    child: Center(
                      child: Text(
                          (_log)
                              ? "Pas encore de compte ? Inscrivez-vous !"
                              : "Déjà inscrit ? Connectez-vous !",
                          textAlign: TextAlign.center),
                    )))
          ]),
        ));
  }

  _handleLog() {
    if (_mail.isNotEmpty) {
      if (EmailValidator.validate(_mail)) {
        if (_pwd.isNotEmpty) {
          setState(() {
            _errorMessage = "Le mot de passe doit être reseigné";
          });
          //Pour la connexion
          if (_log) {
            auth.handleSignIn(_mail, _pwd);
          } else {
            //creation de compte
            if (_firstname.isNotEmpty && _lastname.isNotEmpty) {
              auth.create(_mail, _pwd, _firstname, _lastname);
              setState(() {
                _errorMessage = "";
              });
            } else {
              setState(() {
                _errorMessage = "Le nom et prénom doivent être renseigné";
              });
            }
          }
        }
      } else {
        setState(() {
          _errorMessage = "L'adresse mail est invalide";
        });
      }
    }
  }

  List<Widget> textfields() {
    List<Widget> textfield = [];
    textfield.add(
      SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo Find'),
    );
    if (_log) {
      textfield.add(
        TextField(
          decoration: InputDecoration(
            hintText: "Adresse mail",
            // errorText: 'Le prénom n\'est pas valide',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (String value) {
            setState(() {
              _mail = value;
            });
          },
        ),
      );
      textfield.add(TextField(
        decoration: InputDecoration(
          hintText: "Mot de passe",
          // errorText: 'Le prénom n\'est pas valide',
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
      ));
    } else {
      textfield.add(DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        underline: Container(
          height: 10,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Femme', 'Homme']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ));
      textfield.add(Container(
          child: Row(children: [
        Expanded(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Prénom*",
                // errorText: 'Le prénom n\'est pas valide',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _firstname = value;
                });
              },
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Nom*",
                // errorText: 'Le prénom n\'est pas valide',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _lastname = value;
                });
              },
            )
          ],
        ))
      ])));
      textfield.add(IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'Numéro de téléphone*',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        initialCountryCode: 'FR',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ));
      textfield.add(
        TextField(
          decoration: InputDecoration(
            hintText: "Email*",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (String value) {
            setState(() {
              _mail = value;
            });
          },
        ),
      );
      textfield.add(TextField(
        decoration: InputDecoration(
          hintText: "Mot de passe*",
          // errorText: 'Le prénom n\'est pas valide',
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
      ));
      textfield.add(Text(
        _errorMessage,
        style: TextStyle(color: Colors.red),
      ));
    }
    return textfield;
  }
}
