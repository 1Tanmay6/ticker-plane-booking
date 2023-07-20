import 'package:flutter/material.dart';

import '../screens/landingScreen.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/bottomNavBar';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LandingScreen(),
    Text('Tickets Page'),
    Text('History Page'),
    Text('Settings Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.primary,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: media.height * 0.015,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: media.height * 0.015,
            fontWeight: FontWeight.w600,
            color: colorScheme.secondary),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                color: colorScheme.secondary),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1
                    ? Icons.confirmation_number
                    : Icons.confirmation_number_outlined,
                color: colorScheme.secondary),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 2 ? Icons.history : Icons.history_toggle_off,
                color: colorScheme.secondary),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
                color: colorScheme.secondary),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorScheme.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}
