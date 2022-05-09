import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widget/tool_bar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsController extends StatefulWidget {
  final bool find;
  final String category;
  const DetailsController(
      {Key? key, required this.find, required this.category})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => DetailsControllerState();
}

class DetailsControllerState extends State<DetailsController> {
  String _address = "";
  String _model = "";
  String _brand = "";
  Color _color = const Color(0xFF39ADAD);
  String _description = "";

  TextEditingController timeinput = TextEditingController();
  TextEditingController _dateinput = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  void initState() {
    _dateinput.text = "";
    timeinput.text = "";
    super.initState();
  }

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
                    onPressed: () {},
                    child: Text('Suivant', textAlign: TextAlign.center))),
          ]),
        ));
  }

  List<Widget> textfields() {
    List<Widget> textfield = [];
    textfield.add(
      SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo Find'),
    );

    textfield.add(Text("Où et quand avez-vous perdu votre objet ?"));

    textfield.add(
      TextField(
        decoration: InputDecoration(
          hintText: "Adresse",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (String value) {
          setState(() {
            _address = value;
          });
        },
      ),
    );
    textfield.add(TextField(
      style: TextStyle(color: const Color(0xFF39ADAD)),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Date",
      ),
      controller: _dateinput,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: const Color(0xFF39ADAD),
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: const Color(0xFF39ADAD),
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101));
        if (pickedDate != null && pickedDate.compareTo(DateTime.now()) < 0) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _dateinput.text = formattedDate;
          });
        } else {
          print("Impossible de mettre une date qui n'est pas encore passée");
        }
      },
      obscureText: true,
    ));
    textfield.add(TextField(
        controller: timeinput,
        decoration: InputDecoration(
          hintText: "Heure",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
            print(formattedTime);

            setState(() {
              timeinput.text = formattedTime;
            });
          } else {
            print("Time is not selected");
          }
        }));
    textfield.add(Text("Description de l’objet", textAlign: TextAlign.left));
    textfield.add(TextField(
      decoration: InputDecoration(
        hintText: "Modèle",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _model = value;
        });
      },
    ));
    textfield.add(TextField(
      decoration: InputDecoration(
        hintText: "Marque",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _brand = value;
        });
      },
    ));
    textfield.add(TextFormField(
      minLines: 6,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _description = value;
        });
      },
    ));
    return textfield;
  }
}
