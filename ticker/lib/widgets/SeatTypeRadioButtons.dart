import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';

enum ClassType { window, middle, aisle }

class SeatType extends StatefulWidget {
  @override
  _SeatTypeState createState() => _SeatTypeState();
}

class _SeatTypeState extends State<SeatType> {
  ClassType? _classType = ClassType.window;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final utilProvider = Provider.of<UtilProviders>(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ClassType>(
                activeColor: colorScheme.secondary,
                value: ClassType.window,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('Window');
                  });
                },
              ),
              const Text('Window'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ClassType>(
                activeColor: colorScheme.secondary,
                value: ClassType.middle,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('Middle');
                  });
                },
              ),
              const Text('Middle'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ClassType>(
                activeColor: colorScheme.secondary,
                value: ClassType.aisle,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('Aisle');
                  });
                },
              ),
              const Text('Aisle'),
            ],
          ),
        ],
      ),
    );
  }
}
