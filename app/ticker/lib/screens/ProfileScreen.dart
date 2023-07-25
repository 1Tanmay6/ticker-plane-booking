import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_services.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool _darkMode = MyApp.darkMode.value;
    final authProvider = Provider.of<AuthServices>(context);

    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildInput({
      required String label,
      required bool hasIcon,
      Function? func,
      Widget? icon,
      required bool passengerCount,
      TextEditingController? controller,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: media.width * 0.75,
        height: media.height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(7.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  spreadRadius: 1)
            ]),
        child: TextField(
          readOnly: true,
          controller: controller,
          style: textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: colorScheme.secondary,
              fontSize: media.height * 0.018),
          cursorColor: colorScheme.secondary,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.keyboard_arrow_right_outlined),
            icon: hasIcon ? icon! : null,
            border: InputBorder.none,
          ),
          onTap: () {
            if (func != null) {
              func();
              print(MyApp.darkMode.value);
            }
          },
        ),
      );
    }

    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: media.height,
          width: media.width,
          color: colorScheme.primary,
        ),
        Container(
          height: media.height * 0.45,
          width: media.width,
          color: colorScheme.secondary,
        ),
        Column(
          children: [
            Container(
              height: media.height * 0.15,
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: media.height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Profile',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onSecondary, fontSize: 25)),
                        FloatingActionButton.small(
                          heroTag: 'Logout',
                          backgroundColor: colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: () {
                            authProvider.signOut(context);
                          },
                          child: Icon(Icons.power_settings_new_rounded,
                              color: colorScheme.secondary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: media.height * 0.69, //? Here is the height
              width: media.width * 0.85,

              decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: media.height * 0.22,
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          authProvider.user!.photoURL!),
                                      radius: media.height * 0.065,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(authProvider.user!.displayName!,
                                    style: textTheme.displayLarge!.copyWith(
                                        fontSize: 20,
                                        color: colorScheme.secondary)),
                                Text(authProvider.user!.email!,
                                    style: textTheme.displayLarge!.copyWith(
                                        fontSize: 13,
                                        color: colorScheme.secondary,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          // color: Colors.red,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: media.height * 0.28,
                                  // color: Colors.blue,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Settings',
                                              style: textTheme.displayLarge!
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color:
                                                          colorScheme.secondary,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildInput(
                                          label: 'Payment Method',
                                          hasIcon: true,
                                          passengerCount: false,
                                          controller: TextEditingController(
                                              text: 'Payment Method'),
                                          icon: const Icon(Icons.wallet)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _buildInput(
                                          label: 'Language',
                                          hasIcon: true,
                                          passengerCount: false,
                                          controller: TextEditingController(
                                              text: 'Language'),
                                          icon: const Icon(Icons.language)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _buildInput(
                                          label: 'Dark Mode',
                                          hasIcon: true,
                                          passengerCount: false,
                                          controller: TextEditingController(
                                              text: _darkMode
                                                  ? 'Light Mode'
                                                  : 'Dark Mode'),
                                          func: () {
                                            setState(() {
                                              _darkMode = !_darkMode;
                                              MyApp.darkMode.value = _darkMode;
                                            });
                                          },
                                          icon: _darkMode
                                              ? Icon(Icons.sunny)
                                              : Icon(Icons.dark_mode))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: media.height * 0.14,
                                  // color: Colors.blue,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Support',
                                              style: textTheme.displayLarge!
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color:
                                                          colorScheme.secondary,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildInput(
                                          label: 'Help Center',
                                          hasIcon: true,
                                          passengerCount: false,
                                          controller: TextEditingController(
                                              text: 'Help Center'),
                                          icon: const Icon(
                                              Icons.message_outlined)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                        // SingleChildScrollView(
                        //   child: Column(
                        //     children: [

                        //     ],
                        //   ),
                        // ),
                      ], // ? End of the children
                    ),
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
