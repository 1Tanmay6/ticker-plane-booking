import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'auth_services.dart';
import 'firebase_services.dart';
import '../models/planeTicket.dart';

class UtilProviders extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _ticketIsSelected = false;
  //? This is for the temporary ticket selection
  bool _isTempTicketSelected = false;
  bool _isTempClassSelected = false;
  String _currrentClass = 'Economy';
  int _numberOfPassengers = 1;
  double _finalPrice = 0;
  String _seatNumber = 'AXXX';
  String _currrentPackage = 'Basic';
  bool _boughtTicket = false;
  //? END This is for the temporary ticket selection

  String _currentDep = '';
  String _currentArr = '';

  bool get isDarkMode => _isDarkMode;

  int get numberOfPassengers => _numberOfPassengers;

  String get currrentClass => _currrentClass;

  String get currrentPackage => _currrentPackage;

  bool get boughtTicket => _boughtTicket;

  String get seatNumber => _seatNumber;

  String get currentDeps => _currentDep;

  String get currentArr => _currentArr;

  String generateRandomString(int num) {
    final Random random = Random();
    final List<String> letters = ['A', 'B', 'F'];
    final Map<String, int> ranges = {'A': 120, 'B': 10, 'F': 35};
    String letter = '';
    switch (num) {
      case 1:
        letter = letters[0];
        break;
      case 2:
        letter = letters[1];
        break;
      case 3:
        letter = letters[2];
        break;
      default:
        letter = letters[random.nextInt(3)];
    }
    final int number = random.nextInt(ranges[letter]!) + 1;
    return '$letter$number';
  }

  String minsConverter(int mins) {
    if (mins < 60) {
      return mins.toString() + ' mins';
    }

    if (mins == 60) {
      return '1 hr';
    }

    return (mins / 60).floor().toString() +
        ' hrs ' +
        (mins % 60).toString() +
        ' mins';
  }

  String getSeatNumber() {
    switch (_currrentClass) {
      case 'Economy':
        String seat = generateRandomString(1);
        _seatNumber = seat;
        return seat;

      case "Business":
        String seat = generateRandomString(2);
        _seatNumber = seat;
        return seat;

      case 'First Class':
        String seat = generateRandomString(3);
        _seatNumber = seat;
        return seat;

      default:
        return generateRandomString(1);
    }
  }

  double getPrice(double price) {
    double finalPrice = price;

    switch (_currrentPackage) {
      case 'Basic':
        finalPrice += 0;

      case "Standard":
        finalPrice += 750;

      case 'Premium':
        finalPrice += 1500;

      default:
        return 0;
    }

    switch (_currrentClass) {
      case 'Economy':
        finalPrice += 0;

      case "Business":
        finalPrice += 11500;

      case 'First Class':
        finalPrice += 15800;

      default:
        return 0;
    }

    _finalPrice = (finalPrice += 1500) * _numberOfPassengers;
    return (finalPrice += 1500) * _numberOfPassengers;
  }

  Future<String> getDownloadsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final downloadsDirectoryPath = '${directory.path}/Downloads';
    final downloadsDirectory = Directory(downloadsDirectoryPath);
    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create(recursive: true);
    }
    return downloadsDirectoryPath;
  }

  List<PlaneTicket> searchPlanes(
      {required BuildContext context,
      required String departureStateCode,
      required String arrivalStateCode}) {
    List<PlaneTicket> result = [];

    final firebaseProvider =
        Provider.of<FirebaseServies>(context, listen: false);
    List<PlaneTicket> allticket = firebaseProvider.allPlaneTicketItems;

    for (int i = 0; i < allticket.length; i++) {
      if ((allticket[i].departureStateCode.toUpperCase().trim() ==
              departureStateCode.toUpperCase().trim()) &&
          (allticket[i].arrivalStateCode.toUpperCase().trim() ==
              arrivalStateCode.toUpperCase().trim())) {
        result.add(allticket[i]);
      } else if (allticket[i].departureCity.toUpperCase().trim() ==
              departureStateCode.toUpperCase().trim() &&
          allticket[i].arrivalCity.toUpperCase().trim() ==
              arrivalStateCode.toUpperCase().trim()) {
        result.add(allticket[i]);
      }
    }

    return result;
  }

  void shareTicket(BuildContext context, bool down) async {
    final pdf = pw.Document();

    final theme = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFf5f5f5),
        onPrimary: Color(0xFF000000),
        secondary: Color(0xFF151B33),
        onSecondary: Color(0xFF0C4160),
        error: Colors.red,
        onError: Colors.black,
        background: Color(0xFFF7F6FB),
        onBackground: Color(0xFF0C4160),
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: MediaQuery.of(context).size.height * 0.035,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: MediaQuery.of(context).size.height * 0.015,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: MediaQuery.of(context).size.height * 0.015,
          fontWeight: FontWeight.normal,
        ),
      ),
    );

    final authProvider = Provider.of<AuthServices>(context, listen: false);
    final firebaseProvider =
        Provider.of<FirebaseServies>(context, listen: false);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: pw.BoxDecoration(
              boxShadow: [
                pw.BoxShadow(
                    color: PdfColor.fromInt(Colors.black45.value),
                    blurRadius: 3,
                    offset: const PdfPoint(0, 5)),
              ],
              color: PdfColor.fromInt(theme.colorScheme.primary.value),
              borderRadius: pw.BorderRadius.circular(16),
            ),
            margin: pw.EdgeInsets.all(16),
            child: pw.Column(
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(16),
                  child: pw.Text(
                    'Ticket',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Container(
                  padding: pw.EdgeInsets.all(16),
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                  'Date:' +
                                      DateFormat.yMMMd().format(DateTime.now()),
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the name of the ticket holder here
                              pw.Text(
                                  'Time:' +
                                      DateFormat.jm().format(DateTime.now()),
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Name:',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the name of the ticket holder here
                              pw.Text(authProvider.user!.displayName!,
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Seat:',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the name of the ticket holder here
                              pw.Text(_seatNumber,
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.SizedBox(height: 20),
                              pw.Text('Class:',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the seat number here
                              pw.Text(_currrentClass,
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Package:',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the name of the ticket holder here
                              pw.Text(_currrentPackage,
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Price:',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                              pw.SizedBox(height: 20),
                              // Add the name of the ticket holder here
                              pw.Text(_finalPrice.toStringAsFixed(2),
                                  style: pw.TextStyle(
                                      color: PdfColor.fromInt(
                                          theme.colorScheme.secondary.value))),
                            ]),
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (down) {
      final directoryPath = await getDownloadsDirectoryPath();
      final file = File('$directoryPath/my_ticket.pdf');
      await file.writeAsBytes(await pdf.save());
    } else {
      await Printing.sharePdf(
          bytes: await pdf.save(), filename: 'my_ticket.pdf');
    }
  }

  void toggleTempTicketSelected() {
    _isTempTicketSelected = !_isTempTicketSelected;
    notifyListeners();
  }

  void toggleTempClassSelected() {
    _isTempClassSelected = !_isTempClassSelected;
    notifyListeners();
  }

  void classSelected(String className) {
    _currrentClass = className;
    notifyListeners();
  }

  // void seatSelected(String seatName) {
  //   _currrentSeat = seatName;
  //   notifyListeners();
  // }

  void setBoughtTicket() {
    _boughtTicket = !_boughtTicket;
    notifyListeners();
  }

  void setCurrentDeps(String currentDeps) {
    _currentDep = currentDeps;
    notifyListeners();
  }

  void setCurrentArr(String currentArr) {
    _currentArr = currentArr;
    notifyListeners();
  }

  void packageSelected(String packageName) {
    _currrentPackage = packageName;
    notifyListeners();
  }

  void incrementPassengers() {
    _numberOfPassengers++;
    notifyListeners();
  }

  void decrementPassengers() {
    if (_numberOfPassengers > 1) {
      _numberOfPassengers--;
      notifyListeners();
    }
  }

  void resetTempSelection() {
    _isTempTicketSelected = false;
    _isTempClassSelected = false;
    _currrentClass = 'Economy';
    _currrentPackage = 'Basic';
    notifyListeners();
  }
}
