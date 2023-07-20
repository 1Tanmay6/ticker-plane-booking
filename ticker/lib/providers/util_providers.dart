import 'package:flutter/material.dart';

class UtilProviders extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  String minsConverter(int mins) {
    if (mins < 60) {
      return mins.toString() + ' mins';
    }

    if (mins == 60) {
      return '1 hr';
    }
    // else {
    //   return (mins / 60).floor().toString() + ' hrs';
    // }

    return (mins / 60).floor().toString() +
        ' hrs ' +
        (mins % 60).toString() +
        ' mins';
  }
}
