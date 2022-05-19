import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'category_controller.dart';
import '../../widget/toolbar.dart';

void main() {
  runApp(FindController());
}

class FindController extends StatefulWidget {
  const FindController({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FindControllerState();
}

class FindControllerState extends State<FindController> {
  bool _find = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Container(
              margin: const EdgeInsets.only(
                  top: 70, bottom: 50, left: 20, right: 20),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/logo.svg',
                        semanticsLabel: 'Logo Find'),
                    SizedBox(height: 70),
                    SizedBox(
                        width: 250,
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
                              setState(() {
                                _find = true;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryController(find: _find)));
                            },
                            child: Text("J'ai trouvé un objet",
                                textAlign: TextAlign.center))),
                    SizedBox(height: 50),
                    SizedBox(
                        width: 250,
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
                              setState(() {
                                _find = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryController(find: _find)));
                            },
                            child: Text("J'ai perdu un objet",
                                textAlign: TextAlign.center))),
                  ]))
        ]),
        bottomNavigationBar: ToolBar());
  }
}
