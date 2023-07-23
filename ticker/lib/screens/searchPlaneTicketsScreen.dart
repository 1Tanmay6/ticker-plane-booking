import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plane_ticker/widgets/ticket.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../models/planeTicket.dart';
import '../providers/util_providers.dart';

class SearchPlaneTicketScreen extends StatefulWidget {
  static const routeName = '/searchPlaneTicket';
  List<PlaneTicket> results = [];
  SearchPlaneTicketScreen({required this.results});

  @override
  State<SearchPlaneTicketScreen> createState() =>
      _SearchPlaneTicketScreenState();
}

class _SearchPlaneTicketScreenState extends State<SearchPlaneTicketScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final utilProvider = Provider.of<UtilProviders>(context);
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      Container(
        height: media.height * 0.45,
        width: media.width,
        color: colorScheme.secondary,
      ),
      Column(children: [
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
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onPressed: () {
                        // utilProvider.resetTempSelection();
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_rounded,
                          color: colorScheme.secondary),
                    ),
                    Text('Search Results',
                        style: textTheme.displayLarge!.copyWith(
                            color: colorScheme.primary, fontSize: 25)),
                    FloatingActionButton.small(
                      heroTag: 'Refresh',
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onPressed: () {
                        // utilProvider.shareTicket(context, false);
                        // utilProvider.resetTempSelection();
                      },
                      child: Icon(Icons.refresh_rounded,
                          color: colorScheme.secondary),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
            height: media.height * 0.65, //? Here is the height
            width: media.width * 0.85,
            decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
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
                      children: [
                        Text('${widget.results.length} Results Found',
                            style: textTheme.displayLarge!.copyWith(
                                color: colorScheme.secondary, fontSize: 25)),
                        Expanded(
                          child: widget.results.length == 0
                              ? Text('No results Found')
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Ticket(
                                        ticket: widget.results[index]);
                                  },
                                  itemCount: widget.results.length,
                                ),
                        )
                      ],
                    ))))
      ])
    ]));
  }
}
