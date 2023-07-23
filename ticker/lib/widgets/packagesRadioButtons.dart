import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';

enum FlightPackage { basic, standard, premium }

class MyFlightPackage extends StatefulWidget {
  @override
  _MyFlightPackageState createState() => _MyFlightPackageState();
}

class _MyFlightPackageState extends State<MyFlightPackage> {
  FlightPackage? _flightPackage = FlightPackage.basic;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final utilProvider = Provider.of<UtilProviders>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Basic'),
            subtitle: const Text(
              'Perks: 1 carry-on bag, in-flight meal',
              style: TextStyle(fontSize: 12),
            ),
            leading: Radio<FlightPackage>(
              activeColor: colorScheme.secondary,
              value: FlightPackage.basic,
              groupValue: _flightPackage,
              onChanged: (FlightPackage? value) {
                setState(() {
                  _flightPackage = value;
                  utilProvider.packageSelected('Basic');
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Standard'),
            subtitle: const Text(
              'Perks: 1 checked bag, 1 carry-on bag, in-flight meal and entertainment',
              style: TextStyle(fontSize: 12),
            ),
            leading: Radio<FlightPackage>(
              activeColor: colorScheme.secondary,
              value: FlightPackage.standard,
              groupValue: _flightPackage,
              onChanged: (FlightPackage? value) {
                setState(() {
                  _flightPackage = value;
                  utilProvider.packageSelected('Standard');
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Premium'),
            subtitle: const Text(
              'Perks: Priority boarding, 2 checked bags, 1 carry-on bag, in-flight meal and entertainment, lounge access',
              style: TextStyle(fontSize: 12),
            ),
            leading: Radio<FlightPackage>(
              activeColor: colorScheme.secondary,
              value: FlightPackage.premium,
              groupValue: _flightPackage,
              onChanged: (FlightPackage? value) {
                setState(() {
                  _flightPackage = value;
                  utilProvider.packageSelected('Premium');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
