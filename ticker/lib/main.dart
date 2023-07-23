import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plane_ticker/providers/firebase_services.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'providers/auth_services.dart';
import 'providers/util_providers.dart';
import 'screens/postConfirmScreen.dart';
import 'screens/getStarted.dart';
import 'screens/loginRegisterScreen.dart';
import 'screens/landingScreen.dart';
import 'screens/BottomNavBar.dart';
import 'screens/TicketDetailScreen.dart';
import 'models/planeTicket.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    name: 'ticker',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseServies(),
        ),
      ],
      child: MaterialApp(
        title: 'Ticker',
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xFFf5f5f5),
                onPrimary: Color(0xFF000000),
                secondary: Color(0xFF24445C),
                onSecondary: Color(0xFF0C4160),
                error: Colors.red,
                onError: Colors.black,
                background: Color(0xFFf5f5f5),
                onBackground: Color(0xFF0C4160),
                surface: Colors.white,
                onSurface: Colors.black),
            useMaterial3: true,
            textTheme: TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontWeight: FontWeight.w600,
              ),
              bodySmall: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).size.height * 0.015,
                fontWeight: FontWeight.normal,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).size.height * 0.015,
                fontWeight: FontWeight.normal,
              ),
            )).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        home: const GetStartedScreen(),
        // home: PostConfirmScreen(
        //   ticket: PlaneTicket(
        //     id: '1',
        //     airportName: 'JFK International Airport',
        //     departureCity: 'New York City',
        //     arrivalCity: 'Los Angeles',
        //     departureStateCode: 'NY',
        //     arrivalStateCode: 'CA',
        //     departureDate: DateTime(2022, 12, 1, 8, 15).toIso8601String(),
        //     arrivalDate: DateTime(2022, 12, 1, 11, 45).toIso8601String(),
        //     travelTime: 210,
        //     price: 25000.00,
        //     airwayName: 'Delta Airlines',
        //     airplaneName: 'Boeing 737',
        //   ),
        // ),
        routes: {
          GetStartedScreen.routeName: (context) => const GetStartedScreen(),
          LoginRegisterScreen.routeName: (context) =>
              const LoginRegisterScreen(),
          LandingScreen.routeName: (context) => const LandingScreen(),
          BottomNavBar.routeName: (context) => BottomNavBar(),
        },
      ),
    );
  }
}
