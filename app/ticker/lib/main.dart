import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plane_ticker/providers/firebase_services.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'providers/auth_services.dart';
import 'providers/util_providers.dart';
import 'screens/getStarted.dart';
import 'screens/loginRegisterScreen.dart';
import 'screens/landingScreen.dart';
import 'screens/BottomNavBar.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    name: 'ticker',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  static ValueNotifier<bool> darkMode = ValueNotifier(false);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      child: ValueListenableBuilder<bool>(
        valueListenable: MyApp.darkMode,
        builder: (context, value, child) => MaterialApp(
          title: 'Ticker',
          themeMode: value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Color(0xFFf5f5f5),
                  onPrimary: Color(0xFF000000),
                  secondary: Color(0xFF24445C),
                  onSecondary: Color(0xFFf5f5f5),
                  error: Colors.red,
                  onError: Colors.black,
                  background: Color(0xFF1c1c1e),
                  onBackground: Color(0xFF0C4160),
                  surface: Color(0xFFf5f5f5),
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
          darkTheme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Color(0xFF1c1c1e),
                  onPrimary: Color(0xFFf5f5f5),
                  secondary: Color(0xFF24445C),
                  onSecondary: Color(0xFFf5f5f5),
                  error: Colors.red,
                  onError: Colors.black,
                  background: Color(0xFFf5f5f5),
                  onBackground: Color(0xFFf5f5f5),
                  surface: Colors.white60,
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
          routes: {
            GetStartedScreen.routeName: (context) => const GetStartedScreen(),
            LoginRegisterScreen.routeName: (context) =>
                const LoginRegisterScreen(),
            LandingScreen.routeName: (context) => const LandingScreen(),
            BottomNavBar.routeName: (context) => BottomNavBar(),
          },
        ),
      ),
    );
  }
}
