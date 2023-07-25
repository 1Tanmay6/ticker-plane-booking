import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/planeTicket.dart';
import '../providers/util_providers.dart';

class TicketInfo extends StatelessWidget {
  final PlaneTicket ticket;
  TicketInfo({required this.ticket});

  TextEditingController converter(bool dep) {
    final TextEditingController _departureDateController =
        TextEditingController(
            text:
                DateFormat('Hms').format(DateTime.parse(ticket.departureDate)));
    final TextEditingController _arrivalDateController = TextEditingController(
        text: DateFormat('Hms').format(DateTime.parse(ticket.arrivalDate)));

    return dep ? _departureDateController : _arrivalDateController;
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

    return Column(
      children: [
        Container(
          height: media.height * 0.55, //? Here is the height
          width: media.width * 0.85,

          decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, blurRadius: 10, offset: Offset(0, 5))
              ]),
          child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ticket.airwayName,
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary, fontSize: 18)),
                        Text(ticket.airplaneName,
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary, fontSize: 18))
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
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(ticket.departureCity,
                                      style: textTheme.displayLarge!.copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    ticket.departureStateCode,
                                    style: textTheme.displayLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
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
                              ),
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
                                      style: textTheme.displayLarge!.copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(ticket.arrivalCity,
                                      style: textTheme.displayLarge!.copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    ticket.arrivalStateCode,
                                    style: textTheme.displayLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
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
                              ),
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
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: _buildInput(
                              label: 'Arrival Time',
                              hasIcon: false,
                              passengerCount: false,
                              controller: converter(false)),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black26,
                      height: 50,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.cases_outlined,
                              color: colorScheme.secondary,
                            ),
                          ),
                          Text(
                              ticket.travelTime < 180
                                  ? 'Cabin: 5kgs (1 piece per pax)'
                                  : 'Cabin: 7kgs',
                              style: textTheme.bodySmall!.copyWith(
                                color: colorScheme.secondary,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.luggage_outlined,
                              color: colorScheme.secondary,
                            ),
                          ),
                          Text(
                              ticket.travelTime < 180
                                  ? 'Check-in: 15kgs (1 piece per pax)'
                                  : 'Check-in: 25kgs',
                              style: textTheme.bodySmall!.copyWith(
                                color: colorScheme.secondary,
                              ))
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black26,
                      height: 50,
                      thickness: 1,
                      indent: 25,
                      endIndent: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary, fontSize: 18)),
                        Text(
                            '₹' +
                                ticket.price.toStringAsFixed(2) +
                                ' (1 ticket)',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary, fontSize: 18))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
