import 'package:flutter/material.dart';

class AllTicketsScreen extends StatelessWidget {
  const AllTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tickets'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ticket'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
