// ignore_for_file: camel_case_types, library_private_types_in_public_api, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';

class FlightSelectionLandingWidget_passegerCountWidget extends StatefulWidget {
  const FlightSelectionLandingWidget_passegerCountWidget({super.key});

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

    final utilProvider = Provider.of<UtilProviders>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: media.width * 0.7,
      decoration: BoxDecoration(
          color: colorScheme.onSecondary,
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
            backgroundColor: const Color(0xFFf5f5f5),
            onPressed: () {
              utilProvider.decrementPassengers();
              setState(() {
                _passengerCount = max(1, _passengerCount - 1);
              });
            },
            child: Icon(
              Icons.remove,
              color: colorScheme.secondary,
            ),
            mini: true,
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            backgroundColor: const Color(0xFFf5f5f5),
            onPressed: () {
              utilProvider.incrementPassengers();
              setState(() {
                _passengerCount++;
              });
            },
            child: Icon(
              Icons.add,
              color: colorScheme.secondary,
            ),
            mini: true,
          ),
        ],
      ),
    );
  }
}
