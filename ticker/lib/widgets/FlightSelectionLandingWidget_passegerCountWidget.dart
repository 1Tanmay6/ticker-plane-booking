import 'dart:math';

import 'package:flutter/material.dart';

class FlightSelectionLandingWidget_passegerCountWidget extends StatefulWidget {
  @override
  _FlightSelectionLandingWidget_passegerCountWidgetState createState() =>
      _FlightSelectionLandingWidget_passegerCountWidgetState();
}

class _FlightSelectionLandingWidget_passegerCountWidgetState
    extends State<FlightSelectionLandingWidget_passegerCountWidget> {
  int _passengerCount = 1;
  String get _passengerDescription =>
      _passengerCount == 1 ? ' Person' : ' Persons';
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: media.width * 0.7,
      decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(7.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              style: textTheme.displayLarge!.copyWith(
                  color: Colors.black, fontSize: media.height * 0.017),
              cursorColor: colorScheme.secondary,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Passengers',
                labelStyle:
                    textTheme.bodyMedium!.copyWith(color: Colors.black54),
              ),
              controller: TextEditingController(
                  text: _passengerCount.toString() + _passengerDescription),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _passengerCount = max(1, _passengerCount - 1);
              });
            },
            child: Icon(Icons.remove),
            mini: true,
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _passengerCount++;
              });
            },
            child: Icon(Icons.add),
            mini: true,
          ),
        ],
      ),
    );
  }
}
