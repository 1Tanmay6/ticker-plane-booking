import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_services.dart';
import 'FlightSelectionLandingWidget_passegerCountWidget.dart';

class FlightSelectionBox extends StatefulWidget {
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
    const _width = double.maxFinite;
    const _height = double.maxFinite;

    Widget _buildInput(
        {required String label,
        required bool hasIcon,
        Widget? icon,
        required bool passengerCount,
        TextEditingController? controller,
        double? fontsize}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: media.width * 0.7,
        decoration: BoxDecoration(
            color: colorScheme.background,
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
            onTap: () async {
              if (controller != null) {
                final DateTime? picked = await showDatePicker(
                  context: context,
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
      width: _width,
      height: _height,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0C4160).withOpacity(0.05),
          Color(0xFF0C4160).withOpacity(0.15),
          Color(0xFF0C4160).withOpacity(0.25),
          Color(0xFF0C4160).withOpacity(0.35),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.25),
          Color(0xFF0C4160).withOpacity(0.35),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInput(
              label: 'From',
              hasIcon: true,
              icon: Image.asset(
                'lib/assets/images/takeoff.png',
                height: 26,
              ),
              passengerCount: false),
          SizedBox(
            height: 15,
          ),
          _buildInput(
            label: 'To',
            hasIcon: true,
            icon: Image.asset(
              'lib/assets/images/landing.png',
              height: 26,
            ),
            passengerCount: false,
          ),
          SizedBox(
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
                SizedBox(
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
          SizedBox(
            height: 15,
          ),
          FlightSelectionLandingWidget_passegerCountWidget(),
          SizedBox(
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
                  // Provider.of<FirebaseServies>(context, listen: false)
                  //     .fetchPopularTickets();
                },
                label: Text(
                  'Search',
                  style: textTheme.displayLarge!.copyWith(
                      color: colorScheme.primary,
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
