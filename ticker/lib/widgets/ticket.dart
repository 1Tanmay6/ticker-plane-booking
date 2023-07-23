import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/planeTicket.dart';
import '../providers/util_providers.dart';
import '../screens/TicketDetailScreen.dart';

class Ticket extends StatelessWidget {
  PlaneTicket ticket;

  Ticket({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context).size;

    final utilProvider = Provider.of<UtilProviders>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketDetailScreen(
                    ticket: ticket,
                  )),
        );
      },
      child: Container(
          height: media.height * 0.22,
          width: media.width * 0.9,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ticket.airportName,
                              style: textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Text(
                              '₹' + ticket.price.toStringAsFixed(2),
                              style: textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: colorScheme.onBackground.withOpacity(0.1),
                              width: 1.5),
                          color: colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onBackground.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ]),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: colorScheme.onBackground.withOpacity(0.1),
                              width: 1.5),
                          color: colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onBackground.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ]),
                      child: Row(
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
                              ))
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
