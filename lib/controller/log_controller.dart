import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Authentification")),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  elevation: 7.5,
                  child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: textfields(),
                      )),
                )),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                setState(() {
                  _log = !_log;
                });
              },
              child: Text((_log) ? "Authentication" : "Création de compte"),
            ),
            OutlinedButton(
                onPressed: () {
                  _handleLog();
                },
                child: const Text("Connexion"))
          ]),
        ));
  }

  _handleLog() {
    if (_mail.isNotEmpty) {
      if (_pwd.isNotEmpty) {
        if (_log) {
//connexion
        } else {
          //creation de compte
          if (_firstname.isNotEmpty) {
            if (_lastname.isNotEmpty) {
//methode de creation de compte            }
            } else {
// pas de nom
              alerte("Aucun Nom");
            }
          } else {
            alerte("Aucun Prenom");
          }
        }
      } else {
        alerte('aucun mdp');
      }
    } else {
      alerte("Aucune adresse mail n'a été renseignée");
    }
  }

  List<Widget> textfields() {
    List<Widget> textfield = [];

    textfield.add(
      TextField(
        decoration: const InputDecoration(hintText: "Adresse Mail"),
        onChanged: (String value) {
          setState(() {
            _mail = value;
          });
        },
      ),
    );
    textfield.add(TextField(
      decoration: const InputDecoration(hintText: "Mot de passe"),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _pwd = value;
        });
      },
    ));

    if (!_log) {
      textfield.add(TextField(
        decoration: const InputDecoration(hintText: "Prénom"),
        onChanged: (String value) {
          setState(() {
            _firstname = value;
          });
        },
      ));
      textfield.add(TextField(
        decoration: const InputDecoration(hintText: "Nom"),
        onChanged: (String value) {
          setState(() {
            _lastname = value;
          });
        },
      ));
    }
    return textfield;
  }

  Future<void> alerte(String msg) async {
    Text title = const Text("erreur");
    Text message = Text(msg);
    OutlinedButton outlinedButton = OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('ok'),
    );
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: message,
                  actions: [outlinedButton],
                )
              : AlertDialog(
                  title: title,
                  content: message,
                  actions: [outlinedButton],
                );
        });
  }
}
