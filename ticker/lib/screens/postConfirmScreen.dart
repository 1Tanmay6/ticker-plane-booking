import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../models/planeTicket.dart';
import '../providers/util_providers.dart';
import 'BottomNavBar.dart';

class PostConfirmScreen extends StatelessWidget {
  final PlaneTicket ticket;
  const PostConfirmScreen({super.key, required this.ticket});

  TextEditingController converter(bool dep) {
    final TextEditingController _departureDateController =
        TextEditingController(
            text:
                DateFormat('Hms').format(DateTime.parse(ticket.departureDate)));
    final TextEditingController arrivalDateController = TextEditingController(
        text: DateFormat('Hms').format(DateTime.parse(ticket.arrivalDate)));

    return dep ? _departureDateController : arrivalDateController;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final utilProvider = Provider.of<UtilProviders>(context);

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
            color: colorScheme.onSecondary,
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
              color: Colors.black, fontSize: fontsize ?? media.height * 0.02),
          cursorColor: colorScheme.secondary,
          decoration: InputDecoration(
            icon: hasIcon ? icon! : null,
            border: InputBorder.none,
            labelText: label,
            labelStyle: textTheme.bodyMedium!.copyWith(color: Colors.black54),
          ),
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
                        FloatingActionButton.small(
                          heroTag: 'back',
                          backgroundColor: colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: () {
                            utilProvider.resetTempSelection();
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return BottomNavBar();
                                },
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_back_rounded,
                              color: colorScheme.secondary),
                        ),
                        Text('Success!',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onSecondary, fontSize: 25)),
                        FloatingActionButton.small(
                          heroTag: 'Share',
                          backgroundColor: colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          onPressed: () {
                            utilProvider.shareTicket(context, false);
                            utilProvider.resetTempSelection();
                          },
                          child: Icon(Icons.share_rounded,
                              color: colorScheme.secondary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: media.height * 0.45, //? Here is the height
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(ticket.airwayName,
                                style: textTheme.displayLarge!.copyWith(
                                    color: Colors.black, fontSize: 18)),
                            Text(ticket.airplaneName,
                                style: textTheme.displayLarge!.copyWith(
                                    color: Colors.black, fontSize: 18))
                          ],
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(ticket.departureCity,
                                        style: textTheme.displayLarge!.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      ticket.departureStateCode,
                                      style: textTheme.displayLarge!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        DateFormat('dd MMM yyyy')
                                            .format(DateTime.parse(
                                                ticket.departureDate))
                                            .toString(),
                                        style: textTheme.displayLarge!.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
                                  ],
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'lib/assets/images/ticketIcon.png',
                                        width: 200,
                                      ),
                                      Text(
                                          utilProvider
                                              .minsConverter(ticket.travelTime),
                                          style: textTheme.displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13)),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(ticket.arrivalCity,
                                        style: textTheme.displayLarge!.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      ticket.arrivalStateCode,
                                      style: textTheme.displayLarge!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        DateFormat('dd MMM yyyy')
                                            .format(DateTime.parse(
                                                ticket.arrivalDate))
                                            .toString(),
                                        style: textTheme.displayLarge!.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13)),
                                  ],
                                )),
                          ],
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: _buildInput(
                                    label: 'Departure Time',
                                    hasIcon: false,
                                    passengerCount: false,
                                    controller: converter(true))),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: _buildInput(
                                  label: 'Arrival Time',
                                  hasIcon: false,
                                  passengerCount: false,
                                  controller: converter(false)),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        _buildInput(
                            label: 'Seat Number',
                            hasIcon: true,
                            passengerCount: false,
                            icon: Icon(
                              Icons.chair_rounded,
                              color: colorScheme.secondary,
                            ),
                            controller: TextEditingController(
                                text: utilProvider.seatNumber)),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ), //? End of the main container
            Container(
                height: media.height * 0.25, //? Here is the height
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
                child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    // color: colorScheme.surface,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Scan QR',
                                  style: textTheme.displayLarge!.copyWith(
                                      color: colorScheme.secondary,
                                      fontSize: 20)),
                              Expanded(
                                child: SfBarcodeGenerator(
                                  barColor: Colors.black,
                                  value:
                                      'https://pizza-delivery-mu.vercel.app/',
                                  symbology: QRCode(),
                                ),
                              )
                            ])))),
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              height: media.height * 0.07,
              width: media.width * 0.85,
              child: FloatingActionButton.extended(
                  icon: const Icon(Icons.save_alt_outlined),
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    utilProvider.shareTicket(context, true);
                    utilProvider.resetTempSelection();
                  },
                  label: Text(
                    'Download Ticket',
                    style: textTheme.displayLarge!.copyWith(
                        color: colorScheme.onSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: media.height * 0.02),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
