import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          icon: Icon(Icons.arrow_back, size: 30.0),
          onPressed: () {
            Navigator.pop(context, false);
          }),
      Spacer(),
      IconButton(
          icon: Icon(Icons.clear_sharp, size: 30.0),
          onPressed: () {
            Navigator.pop(context, false);
          })
    ]);
  }
}
