import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'details_controller.dart';

class CategoryController extends StatefulWidget {
  final bool find;
  const CategoryController({Key? key, required this.find}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CategoryControllerState();
}

class CategoryControllerState extends State<CategoryController> {
  static final List<String> _categories = [
    'Portefeuille, CB, argent',
    'Papiers d\'identite',
    'Sacs et bagages',
    'Informatique, electronique',
    'Bijoux, accessoires',
    'Vetements',
    'Clés',
    'Divers'
  ];
  String _category = "";

  @override
  Widget build(BuildContext context) {
    final bool _find = widget.find;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Column(children: [
                  SvgPicture.asset('assets/logo.svg',
                      semanticsLabel: 'Logo Find'),
                  Text("Selectionnez une catégorie", textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[0];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/argent.svg',
                                  semanticsLabel:
                                      'Categorie portefeuille, CB, argent')),
                          Text('Portefeuille, CB, argent'),
                        ]),
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[1];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/identity.svg',
                                  semanticsLabel: 'Papiers d\'identite')),
                          Text('Papiers d\'identité'),
                        ]),
                      ]),
                  SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[2];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/sacs.svg',
                                  semanticsLabel: 'Sacs et bagages')),
                          Text('Sacs et bagages'),
                        ]),
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[3];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/informatique.svg',
                                  semanticsLabel:
                                      'Informatique, electronique')),
                          Text('Informatique, electronique'),
                        ]),
                      ]),
                  SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[4];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/accessoires.svg',
                                  semanticsLabel: 'Bijoux, accessoires')),
                          Text('Bijoux, accessoires'),
                        ]),
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[5];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/vetements.svg',
                                  semanticsLabel: 'Vetements')),
                          Text('Vetements'),
                        ]),
                      ]),
                  SizedBox(height: 50),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[6];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/key.svg',
                                  semanticsLabel: 'Clés')),
                          Text('Clés'),
                        ]),
                        Column(children: [
                          IconButton(
                              iconSize: 120.0,
                              onPressed: () {
                                setState(() {
                                  _category = _categories[7];
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsController(
                                        find: _find, category: _category)));
                              },
                              icon: SvgPicture.asset('assets/other.svg',
                                  semanticsLabel: 'Autre')),
                          Text('Autre'),
                        ]),
                      ]),
                ]),
              )),
        ]),
      ),
    );
  }
}
