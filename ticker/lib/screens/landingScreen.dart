import 'package:flutter/material.dart';
import 'package:plane_ticker/providers/firebase_services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../providers/auth_services.dart';
import '../widgets/FlightSelectionLandingWidget.dart';
import '../widgets/profilePictureWidget.dart';
import '../models/planeTicket.dart';
import '../widgets/ticket.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = '/landing';
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<PlaneTicket> _planePopularTickets = [];
  bool init = false;

  @override
  void didChangeDependencies() async {
    if (!init) {
      final firebaseServices = Provider.of<FirebaseServies>(context);
      // TODO: implement didChangeDependencies
      await firebaseServices.fetchPopularTickets();
      await firebaseServices.fetchAllTickets();

      _planePopularTickets = firebaseServices.planeTicketItems;
      init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseServices2 = Provider.of<FirebaseServies>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context).size;

    List<Widget> _buildPopularTickets() {
      List<Widget> _tickets = [];
      _planePopularTickets.forEach((ticket) {
        _tickets.add(Ticket(ticket: ticket));
        _tickets.add(const SizedBox(height: 10));
      });
      return _tickets;
    }

    final imageUrl = Provider.of<AuthServices>(context).user!.photoURL!;
    final userName = Provider.of<AuthServices>(context).user!.displayName!;

    return (firebaseServices2.allPlaneTicketItems.isEmpty || !init)
        ? Center(
            child: LoadingAnimationWidget.beat(
                color: colorScheme.secondary, size: 35))
        : Stack(
            children: [
              Container(
                height: media.height * 0.45,
                width: media.width,
                alignment: Alignment.topRight,
                color: colorScheme.secondary,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.25),
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
                                color:
                                    colorScheme.onBackground.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                              )
                            ]),
                        child: InkWell(
                          onTap: () {
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
                          ProfilePicture(
                              imageUrl: imageUrl, userName: userName),
                          SizedBox(
                            height: media.height * 0.025,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: media.width * 0.87,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Text('Safely reserve your plane ticket.',
                                style: textTheme.displayLarge!.copyWith(
                                    fontSize: media.height * 0.035,
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(
                            height: media.height * 0.025,
                          ),
                          Container(
                              height: media.height * 0.43,
                              width: media.width * 0.8,
                              alignment: Alignment.topCenter,
                              child: FlightSelectionBox()),
                          SizedBox(
                            height: media.height * 0.025,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: media.width * 0.87,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Popular Destinations',
                                    style: textTheme.displayLarge!.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    DateFormat('dd MMMM')
                                        .format(DateTime.now()),
                                    style: textTheme.displayLarge!.copyWith(
                                        color: colorScheme.onPrimary
                                            .withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          ..._buildPopularTickets(),
                        ],
                      ),
                    )),
              )
            ],
          );
  }
}
