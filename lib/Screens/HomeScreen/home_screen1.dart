import 'package:esihapp/Screens/AccountSettingsScreen/account_settings_screen.dart';
import 'package:esihapp/Screens/AgendaScreen/agenda_screen.dart';
import 'package:esihapp/Screens/HomeScreen/home_page.dart';
import 'package:esihapp/Screens/SpecialiteScreen/specialite_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../HealthScreens/health_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    const SpecialiteScreen(),
    const HealthScreen(),
    // AgendaScreen(),
    const AccountSettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: GNav(
          backgroundColor: Colors.greenAccent,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey,
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
            print(index);
          },
          tabs: const [
            GButton(icon: Icons.home, text: "Accueil"),
            GButton(icon: Icons.category, text: "Spécialités"),
            GButton(icon: Icons.calendar_today, text: "Consultation"),
            GButton(icon: Icons.settings, text: "Paramètres"),
          ]),
    );
  }
}
