import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'summary_controller.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../widget/header.dart';

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
  Color color = const Color(0xFF39ADAD);
  String _description = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController _timeinput = TextEditingController();
  TextEditingController _dateinput = TextEditingController();

  void initState() {
    _dateinput.text = "";
    _timeinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool _find = widget.find;
    final String _category = widget.category;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin:
              const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
          child: Header(),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height,
          child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: textfields()))),
        ),
        SizedBox(
            width: 250,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color(0xFF39ADAD),
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SummaryController(
                                find: _find,
                                category: _category,
                                address: _address,
                                hours: _timeinput.text,
                                date: _dateinput.text,
                                model: _model,
                                brand: _brand,
                                color: color,
                                description: _description)));
                      }
                    },
                    child: Text('Suivant', textAlign: TextAlign.center)))),
      ]),
    ));
  }

  List<Widget> textfields() {
    List<Widget> textfield = [];
    textfield.add(
      SvgPicture.asset('assets/logo.svg', semanticsLabel: 'Logo Find'),
    );

    textfield.add(Text("Où et quand avez-vous perdu votre objet ?",
        style: TextStyle(
          fontWeight: FontWeight.w800,
        )));

    textfield.add(
      TextFormField(
        autofocus: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner une adresse';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Adresse",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
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
    textfield.add(TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez renseigner une date';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
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
    ));
    textfield.add(TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez renseigner une heure';
          }
          return null;
        },
        controller: _timeinput,
        decoration: InputDecoration(
          labelText: "Heure",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
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
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime.format(context).toString());
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
            print(formattedTime);

            setState(() {
              _timeinput.text = formattedTime;
            });
          }
        }));
    textfield.add(Text("Description de l’objet",
        style: TextStyle(
          fontWeight: FontWeight.w800,
        )));
    textfield.add(TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez renseigner un modèle';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nom du modèle",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _model = value;
        });
      },
    ));
    textfield.add(TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez renseigner le nom de la marque';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nom de la marque",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _brand = value;
        });
      },
    ));
    textfield.add(OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color(0xFF39ADAD),
          minimumSize: const Size.fromHeight(50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () => pickColor(context),
        child:
            Text('Couleur principal de l’objet', textAlign: TextAlign.center)));
    textfield.add(TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez renseigner une couleur';
        }
        return null;
      },
      minLines: 6,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        labelText: "Description",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: const Color(0xFF39ADAD)),
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

  Widget buildColorPicker() => BlockPicker(
        pickerColor: color,
        availableColors: [
          Colors.green,
          Colors.orange,
          Colors.blue,
          Colors.pink,
          Colors.yellow,
          Colors.cyanAccent,
          Colors.purple,
          Colors.red,
          Colors.deepOrange,
          Colors.teal,
          Colors.indigoAccent,
          Colors.cyan,
          Colors.blueGrey,
          Colors.brown,
          Colors.black,
          Colors.white
        ],
        onColorChanged: (color) => setState(() => this.color = color),
      );

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              buildColorPicker(),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: const Color(0xFF39ADAD),
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Selectionner cette couleur',
                      textAlign: TextAlign.center)),
            ]),
          ));
}
