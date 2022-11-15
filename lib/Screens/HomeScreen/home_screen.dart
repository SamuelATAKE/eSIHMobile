import 'package:esihapp/Screens/AccountSettingsScreen/account_settings_screen.dart';
import 'package:esihapp/Screens/AgendaScreen/agenda_screen.dart';
import 'package:esihapp/Screens/HealthScreens/health_screen.dart';
import 'package:esihapp/Screens/HomeScreen/home_page.dart';
import 'package:esihapp/Screens/SpecialiteScreen/specialite_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const [
    HomePage(),
    SpecialiteScreen(),
    HealthScreen(),
    // AgendaScreen(),
    AccountSettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green,
        animationDuration: const Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: "Accueil",
            selectedIcon: Icon(
              Icons.home,
              color: Color(0xff1E1C61),
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
            label: "Spécialités",
            selectedIcon: Icon(Icons.category, color: Color(0xff1E1C61)),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            label: "Consultations",
            selectedIcon: Icon(Icons.calendar_today, color: Color(0xff1E1C61)),
          ),
          NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
              label: "Paramètres",
              selectedIcon: Icon(Icons.settings, color: Color(0xff1E1C61))),
        ],
      ),
    );
  }
}
