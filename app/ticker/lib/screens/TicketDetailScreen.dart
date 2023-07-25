import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/planeTicket.dart';
import '../providers/util_providers.dart';
import '../providers/firebase_services.dart';
import '../providers/auth_services.dart';
import '../widgets/TicketInfoTicketDetailScreenWidget.dart';
import '../widgets/PackagePickerTicketDetailScreenWidget.dart';
import 'postConfirmScreen.dart';

class TicketDetailScreen extends StatefulWidget {
  final PlaneTicket ticket;
  TicketDetailScreen({required this.ticket});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  bool _isProceed = false;
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void openCheckout({
    required int amount,
    required String description,
    required String email,
  }) async {
    var options = {
      'key': 'rzp_test_CtU2obRTR3DFu4',
      'amount': amount,
      'name': 'Ticker',
      'description': description,
      'prefill': {'contact': '', 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final utilProvider = Provider.of<UtilProviders>(context, listen: false);
    final firebaseProvider =
        Provider.of<FirebaseServies>(context, listen: false);
    final authProvider = Provider.of<AuthServices>(context, listen: false);
    firebaseProvider.boughtTicket(
        uid: authProvider.uid,
        orderId: DateTime.now().toIso8601String(),
        ticket: widget.ticket.id,
        countPassengers: utilProvider.numberOfPassengers,
        totalPrice: utilProvider.getPrice(widget.ticket.price),
        classType: utilProvider.currrentClass,
        packageType: utilProvider.currrentPackage);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PostConfirmScreen(
                ticket: widget.ticket,
              )),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    final snackBar = SnackBar(
      content: Text(
          'Payment failed! Error code: ${response.code} - ${response.message}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    final snackBar = SnackBar(
      content: Text('External wallet selected: ${response.walletName}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final utilProvider = Provider.of<UtilProviders>(context);

    return Scaffold(
        backgroundColor: colorScheme.primary,
        body: Stack(
          children: [
            Container(
              height: media.height * 0.35,
              width: media.width,
              alignment: Alignment.topRight,
              color: colorScheme.secondary,
            ),
            SizedBox(
              height: media.height,
              width: media.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_rounded,
                                    color: colorScheme.secondary),
                              ),
                              Text('Details',
                                  style: textTheme.displayLarge!.copyWith(
                                      color: colorScheme.onSecondary,
                                      fontSize: 25)),
                              FloatingActionButton.small(
                                heroTag: 'Refresh',
                                backgroundColor: colorScheme.onSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                onPressed: () {},
                                child: Icon(Icons.refresh_rounded,
                                    color: colorScheme.secondary),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  _isProceed
                      ? PackagePickerTicketDetailScreenWidget(
                          ticket: widget.ticket)
                      : TicketInfo(ticket: widget.ticket),
                  SizedBox(
                    height: media.height * 0.05,
                  ),
                  //* Button
                  _isProceed
                      ? SizedBox(
                          height: media.height * 0.07,
                          width: media.width * 0.85,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: FloatingActionButton.extended(
                                      backgroundColor: colorScheme.secondary,
                                      foregroundColor: colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onPressed: () {
                                        setState(() {
                                          _isProceed = true;
                                        });
                                        openCheckout(
                                          amount: utilProvider.getRazorPrice(
                                              widget.ticket.price),
                                          description:
                                              '${widget.ticket.departureCity} to ${widget.ticket.arrivalCity}',
                                          email: Provider.of<AuthServices>(
                                                  context,
                                                  listen: false)
                                              .user!
                                              .email as String,
                                        );
                                      },
                                      label: Text(
                                        'Buy Now',
                                        style: textTheme.displayLarge!.copyWith(
                                            color: colorScheme.onSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: media.height * 0.018),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: FloatingActionButton.extended(
                                      backgroundColor: colorScheme.onSecondary,
                                      foregroundColor: colorScheme.secondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onPressed: () {
                                        setState(() {
                                          _isProceed = true;
                                          utilProvider.resetTempSelection();
                                        });

                                        print(_isProceed);
                                        Navigator.pop(context);
                                        // Provider.of<FirebaseServies>(context, listen: false)
                                        //     .fetchPopularTickets();
                                      },
                                      label: Text(
                                        'Cancel',
                                        style: textTheme.displayLarge!.copyWith(
                                            color: colorScheme.secondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: media.height * 0.018),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ]),
                        )
                      : SizedBox(
                          height: media.height * 0.07,
                          width: media.width * 0.85,
                          child: FloatingActionButton.extended(
                              backgroundColor: colorScheme.secondary,
                              foregroundColor: colorScheme.onSecondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {
                                setState(() {
                                  _isProceed = true;
                                });
                                print(_isProceed);
                                // Provider.of<FirebaseServies>(context, listen: false)
                                //     .fetchPopularTickets();
                              },
                              label: Text(
                                'Proceed',
                                style: textTheme.displayLarge!.copyWith(
                                    color: colorScheme.onSecondary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: media.height * 0.022),
                                textAlign: TextAlign.center,
                              )),
                        ), //? end
                ],
              ),
            )
          ],
        ));
  }
}
