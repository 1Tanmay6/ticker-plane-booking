import 'package:flutter/material.dart';
import 'package:plane_ticker/providers/firebase_services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../providers/auth_services.dart';
import '../providers/util_providers.dart';
import '../widgets/profilePictureWidget.dart';
import '../models/planeTicket.dart';
import '../widgets/ticket.dart';

class AllTicketsScreen extends StatefulWidget {
  const AllTicketsScreen({super.key});

  @override
  State<AllTicketsScreen> createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  List<PlaneTicket> _allTickets = [];

  PlaneTicket ticket = PlaneTicket(
    id: '-1',
    airportName: 'XXXXXX',
    departureCity: 'XXXXXX',
    arrivalCity: 'XXXXXX',
    departureStateCode: 'XX',
    arrivalStateCode: 'XX',
    departureDate: DateTime(1990, 12, 1, 8, 15).toIso8601String(),
    arrivalDate: DateTime(1991, 12, 1, 11, 45).toIso8601String(),
    travelTime: 210,
    price: 25000.00,
    airwayName: 'XX XXXXXX',
    airplaneName: 'XXXXXX XXXX',
  );

  @override
  void didChangeDependencies() async {
    final firebaseServices2 = Provider.of<FirebaseServies>(context);
    final authProvider = Provider.of<AuthServices>(context);
    _allTickets = firebaseServices2.allPlaneTicketItems;
    await firebaseServices2.latestTicketFetcher(authProvider.user!.uid);
    String latestTicketid = firebaseServices2.latestTicket.ticket;
    PlaneTicket something =
        firebaseServices2.allPlaneTicketItems.firstWhere((ticket) {
      return ticket.id == latestTicketid;
    });

    ticket = something;

    super.didChangeDependencies();
  }

  Future<void> _pullToRefresh() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      final firebaseServices2 =
          Provider.of<FirebaseServies>(context, listen: false);

      _allTickets = firebaseServices2.allPlaneTicketItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context).size;

    final utilProvider = Provider.of<UtilProviders>(context);

    final imageUrl = Provider.of<AuthServices>(context).user!.photoURL!;
    final userName = Provider.of<AuthServices>(context).user!.displayName!;

    return Stack(children: [
      Container(
        height: media.height * 0.25,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        width: media.width,
        alignment: Alignment.topRight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0),
                ),
                color: Colors.transparent,
              ),
            ),
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.25),
                ),
                color: Colors.transparent,
              ),
            ),
            Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFF2F3245),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.onBackground.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ]),
                child: InkWell(
                  onTap: () {
                    // _findTicket();
                    print('notifications');
                  },
                  child: Icon(
                    Icons.notifications,
                    color: colorScheme.primary,
                    size: 25,
                  ),
                ))
          ],
        ),
      ),
      SafeArea(
        child: Container(
            height: media.height,
            width: media.width,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfilePicture(imageUrl: imageUrl, userName: userName),
                  SizedBox(
                    height: media.height * 0.025,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.87,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(ticket.departureCity,
                                    style: textTheme.displayLarge!.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  ticket.departureStateCode,
                                  style: textTheme.displayLarge!.copyWith(
                                      color: colorScheme.primary,
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
                                        color: colorScheme.primary,
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
                                    'lib/assets/images/ticketIconWhite.png',
                                    width: 200,
                                  ),
                                  Text(
                                      utilProvider
                                          .minsConverter(ticket.travelTime),
                                      style: textTheme.displayLarge!.copyWith(
                                          color: colorScheme.primary,
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
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  ticket.arrivalStateCode,
                                  style: textTheme.displayLarge!.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    DateFormat('dd MMM yyyy')
                                        .format(
                                            DateTime.parse(ticket.arrivalDate))
                                        .toString(),
                                    style: textTheme.displayLarge!.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13)),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.05,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: media.width * 0.87,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Explore More!',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)),
                        Text(DateFormat('dd MMMM').format(DateTime.now()),
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.height * 0.6,
                    width: media.width * 0.87,
                    child: LiquidPullToRefresh(
                      onRefresh: _pullToRefresh,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Ticket(
                          ticket: _allTickets[index],
                        ),
                        itemCount: _allTickets.length,
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    ]);
  }
}
