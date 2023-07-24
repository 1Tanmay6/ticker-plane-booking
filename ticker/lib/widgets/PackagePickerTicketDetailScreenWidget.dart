// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/util_providers.dart';
import '../widgets/classRadioButtons.dart';
import '../models/planeTicket.dart';
import '../widgets/packagesRadioButtons.dart';

class PackagePickerTicketDetailScreenWidget extends StatefulWidget {
  final PlaneTicket ticket;

  const PackagePickerTicketDetailScreenWidget(
      {super.key, required this.ticket});

  @override
  State<PackagePickerTicketDetailScreenWidget> createState() =>
      _PackagePickerTicketDetailScreenWidgetState();
}

class _PackagePickerTicketDetailScreenWidgetState
    extends State<PackagePickerTicketDetailScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final utilProvider = Provider.of<UtilProviders>(context);

    return Column(
      children: [
        Container(
            height: media.height * 0.7, //? Here is the height
            width: media.width * 0.85,
            decoration: BoxDecoration(
                color: colorScheme.primary,
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
                        //! Class Text
                        Text("Pick a class for your flight",
                            style: textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        const SizedBox(height: 10),
                        //! Class Selection Radio button (bussiness, economy, first class)
                        const MyClass(),
                        //! Seat number allocaated/ available

                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Seat Number',
                                style: textTheme.displayLarge!.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15)),
                            Text(utilProvider.getSeatNumber(),
                                style: textTheme.displayLarge!.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 17))
                          ],
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        //! Package Text
                        Text("Pick a Package for your flight",
                            style: textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        const SizedBox(height: 10),
                        MyFlightPackage(),

                        //! Package selection radio button (basic, standard, premium)
                        const Divider(
                          color: Colors.black26,
                          height: 50,
                          thickness: 1,
                          indent: 25,
                          endIndent: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Total Price',
                                style: textTheme.displayLarge!.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15)),
                            Text(
                                '₹${utilProvider.getPrice(widget.ticket.price).toStringAsFixed(2)} (${utilProvider.numberOfPassengers} tickets)',
                                style: textTheme.displayLarge!.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 17))
                          ],
                        ),
                        //! Price Text
                      ],
                    ))))
      ],
    );
  }
}
