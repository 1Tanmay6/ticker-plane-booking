// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:plane_ticker/models/planeTicket.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';
import '../screens/searchPlaneTicketsScreen.dart';
import 'FlightSelectionLandingWidget_passegerCountWidget.dart';

class FlightSelectionBox extends StatefulWidget {
  const FlightSelectionBox({super.key});

  @override
  State<FlightSelectionBox> createState() => _FlightSelectionBoxState();
}

class _FlightSelectionBoxState extends State<FlightSelectionBox> {
  final _depaturedateController = TextEditingController();
  final _returndateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const width = double.maxFinite;
    const height = double.maxFinite;

    final utilProvider = Provider.of<UtilProviders>(context);

    Widget _buildInput(
        {required String label,
        required bool hasIcon,
        Widget? icon,
        required bool passengerCount,
        TextEditingController? controller,
        bool? dep,
        double? fontsize}) {
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
        child: TextField(
            controller: controller,
            style: textTheme.displayLarge!.copyWith(
                color: Colors.black, fontSize: fontsize ?? media.height * 0.02),
            cursorColor: colorScheme.secondary,
            decoration: InputDecoration(
              icon: hasIcon ? icon! : null,
              border: InputBorder.none,
              labelText: label,
              labelStyle: textTheme.bodyMedium!.copyWith(color: Colors.black54),
            ),
            onChanged: (value) {
              if (dep != null) {
                if (dep) {
                  utilProvider.setCurrentDeps(value);
                } else {
                  utilProvider.setCurrentArr(value);
                }
              }
            },
            onTap: () async {
              if (controller != null) {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: colorScheme
                              .secondary, //Change the color of the buttons here
                        ),
                      ),
                      child: child!,
                    );
                  },
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  final formattedDate =
                      DateFormat('dd MMMM yyyy').format(picked);
                  print('Selected date: $formattedDate');
                  controller.text = formattedDate;
                }
              }
            }),
      );
    }

    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF0C4160).withOpacity(0.05),
          const Color(0xFF0C4160).withOpacity(0.15),
          const Color(0xFF0C4160).withOpacity(0.25),
          const Color(0xFF0C4160).withOpacity(0.35),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.25),
          const Color(0xFF0C4160).withOpacity(0.35),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInput(
              label: 'From',
              hasIcon: true,
              dep: true,
              icon: Image.asset(
                'lib/assets/images/takeoff.png',
                height: 26,
              ),
              passengerCount: false),
          const SizedBox(
            height: 15,
          ),
          _buildInput(
            label: 'To',
            hasIcon: true,
            dep: false,
            icon: Image.asset(
              'lib/assets/images/landing.png',
              height: 26,
            ),
            passengerCount: false,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: media.width * 0.7,
            child: Row(
              children: [
                Expanded(
                    child: _buildInput(
                  label: 'Departure Date',
                  hasIcon: false,
                  passengerCount: false,
                  controller: _depaturedateController,
                  fontsize: media.height * 0.015,
                )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: _buildInput(
                  label: 'Return Date',
                  hasIcon: false,
                  passengerCount: false,
                  controller: _returndateController,
                  fontsize: media.height * 0.015,
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const FlightSelectionLandingWidget_passegerCountWidget(),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            // height: media.height * 0.075,
            width: media.width * 0.5,
            child: FloatingActionButton.extended(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  final dep = utilProvider.currentDeps;
                  final arr = utilProvider.currentArr;

                  if (dep != '' && arr != '') {
                    List<PlaneTicket> results = utilProvider.searchPlanes(
                        context: context,
                        departureStateCode: dep,
                        arrivalStateCode: arr);

                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return SearchPlaneTicketScreen(
                            results: results,
                          );
                        },
                      ),
                    );

                    print('results: $results');
                  } else {
                    print('object');
                  }
                },
                label: Text(
                  'Search',
                  style: textTheme.displayLarge!.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: media.height * 0.02),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
