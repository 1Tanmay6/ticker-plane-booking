import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';

enum ClassType { economy, business, first }

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  ClassType? _classType = ClassType.economy;

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
                toggleable: false,
                activeColor: colorScheme.secondary,
                value: ClassType.economy,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('Economy');
                  });
                },
              ),
              const Text('Economy'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ClassType>(
                activeColor: colorScheme.secondary,
                value: ClassType.business,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('Business');
                  });
                },
              ),
              const Text('Business'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<ClassType>(
                activeColor: colorScheme.secondary,
                value: ClassType.first,
                groupValue: _classType,
                onChanged: (ClassType? value) {
                  setState(() {
                    _classType = value;
                    utilProvider.classSelected('First Class');
                  });
                },
              ),
              const Text('First Class'),
            ],
          ),
        ],
      ),
    );
  }
}
