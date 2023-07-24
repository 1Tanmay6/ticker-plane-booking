import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../models/planeTicket.dart';
import '../providers/auth_services.dart';
import '../providers/firebase_services.dart';
import '../widgets/ticket.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool init = false;
  bool loading = true;
  List<PlaneTicket> results = [];
  @override
  didChangeDependencies() async {
    final authProvider = Provider.of<AuthServices>(context);
    final firebaseProvider = Provider.of<FirebaseServies>(context);
    if (!init) {
      await firebaseProvider.historyFetcher(authProvider.user!.uid);
      results = firebaseProvider.history;
      init = true;
      loading = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                    Text('History',
                        style: textTheme.displayLarge!.copyWith(
                            color: colorScheme.primary, fontSize: 25)),
                    FloatingActionButton.small(
                      heroTag: 'Refresh',
                      backgroundColor: colorScheme.primary,
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
        Container(
            height: media.height * 0.65, //? Here is the height
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
                      children: [
                        Expanded(
                          child: loading
                              ? Center(
                                  child: LoadingAnimationWidget.beat(
                                      color: colorScheme.secondary, size: 35))
                              : results.isEmpty
                                  ? const Center(
                                      child: Text('No results Found'))
                                  : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return Ticket(
                                          ticket: results[index],
                                          history: true,
                                        );
                                      },
                                      itemCount: results.length,
                                    ),
                        )
                      ],
                    ))))
      ])
    ]));
  }
}
