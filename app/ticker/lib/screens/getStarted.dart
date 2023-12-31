import 'package:flutter/material.dart';

import 'loginRegisterScreen.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = '/getStarted';
  const GetStartedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: media.height * 0.6,
            color: colorScheme.secondary,
            alignment: Alignment.center,
            child: ClipRRect(
              child: Image.asset(
                'lib/assets/images/introplane.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: media.height * 0.05,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Explore Exciting Destinations',
                  style: textTheme.displayLarge!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: media.height * 0.025,
                ),
                Text(
                  'Welcome to Ticker! Our app is designed to help you book your next flight with ease. With our app, you can easily search for flights by destination, date, and price.',
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: media.height * 0.025,
                ),
              ],
            ),
          ),
          Container(
            height: media.height * 0.025,
          ),
          SizedBox(
            height: media.height * 0.075,
            width: media.width * 0.75,
            child: FloatingActionButton.extended(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const LoginRegisterScreen();
                      },
                    ),
                  );
                  ;
                },
                label: Text(
                  'Get Started',
                  style: textTheme.displayLarge!.copyWith(
                      color: const Color(0xFFf5f5f5),
                      fontWeight: FontWeight.w500,
                      fontSize: media.height * 0.022),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
