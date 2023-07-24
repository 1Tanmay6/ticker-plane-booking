import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_services.dart';

class LoginRegisterScreen extends StatelessWidget {
  static const routeName = '/loginRegister';
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.secondary,
      body: Container(
        padding: const EdgeInsets.all(10),
        height: media.height,
        width: media.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Connect With Us',
              style: textTheme.displayLarge!.copyWith(
                color: const Color(0xFFf5f5f5),
              ),
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            Container(
                height: media.height * 0.38,
                width: media.width * 0.75,
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.onPrimary.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/images/icon.png',
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        'lib/assets/images/tick.png',
                        height: media.height * 0.04,
                      ),
                      Text('Get 15% off on the first ticket',
                          style: textTheme.bodyMedium),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        'lib/assets/images/tick.png',
                        height: media.height * 0.04,
                      ),
                      Text('Zero cancellation fee',
                          style: textTheme.bodyMedium),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        'lib/assets/images/tick.png',
                        height: media.height * 0.04,
                      ),
                      Text('Get the highest discounts',
                          style: textTheme.bodyMedium),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        'lib/assets/images/tick.png',
                        height: media.height * 0.04,
                      ),
                      Text('Be updated with the latest tickets',
                          style: textTheme.bodyMedium),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: media.height * 0.065,
                        width: media.width * 0.65,
                        child: FloatingActionButton.extended(
                            backgroundColor: colorScheme.secondary,
                            foregroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () {
                              Future.delayed(const Duration(milliseconds: 100))
                                  .then((value) => print(
                                      Provider.of<AuthServices>(context,
                                              listen: false)
                                          .signInWithGoogle(context)));
                            },
                            icon: Image.asset('lib/assets/images/google.png'),
                            label: Text(
                              'Login with Google',
                              style: textTheme.displayLarge!.copyWith(
                                  color: const Color(0xFFf5f5f5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: media.height * 0.018),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
