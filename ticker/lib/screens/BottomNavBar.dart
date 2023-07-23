import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'landingScreen.dart';
import 'TicketsScreen.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/bottomNavBar';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    LandingScreen(),
    AllTicketsScreen(),
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
      backgroundColor: colorScheme.primary,
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _widgetOptions[_selectedIndex],
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
