import 'package:flutter/material.dart';
import '../controller/findForm/find_controller.dart';
import '../controller/messenger/messenger_controller.dart';
import '../controller/profil/profil_controller.dart';
import '../controller/main_app_controller.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  State<ToolBar> createState() => ToolBarState();
}

class ToolBarState extends State<ToolBar> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MainAppController(),
    FindController(),
    MessengerController(),
    ProfilController(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => _widgetOptions.elementAt(_selectedIndex)));
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF39ADAD),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Mes demandes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Ajouter un objet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Mon compte',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
