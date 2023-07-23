import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

import '../models/planeTicket.dart';
import '../models/orderticket.dart';

class FirebaseServies extends ChangeNotifier {
  OrderTicket _latestTicket = OrderTicket(
    orderId: '',
    ticket: '',
    userId: '',
    countPassengers: 0,
    totalPrice: 0.0,
    classType: '',
    packageType: '',
  );
  List<PlaneTicket> _planeTicketItems = [
    // PlaneTicket(
    //   id: '1',
    //   airportName: 'JFK International Airport',
    //   departureCity: 'New York City',
    //   arrivalCity: 'Los Angeles',
    //   departureStateCode: 'NY',
    //   arrivalStateCode: 'CA',
    //   departureDate: DateTime(2022, 12, 1, 8, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 11, 0).toIso8601String(),
    //   travelTime: 164,
    //   price: 25000.00,
    //   airwayName: 'Delta Airlines',
    //   airplaneName: 'Boeing 737',
    // ),
    // PlaneTicket(
    //   id: '2',
    //   airportName: 'LAX International Airport',
    //   departureCity: 'Los Angeles',
    //   arrivalCity: 'New York City',
    //   departureStateCode: 'CA',
    //   arrivalStateCode: 'NY',
    //   departureDate: DateTime(2022, 12, 1, 10, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 13, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 22000.00,
    //   airwayName: 'American Airlines',
    //   airplaneName: 'Airbus A320',
    // ),
    // PlaneTicket(
    //   id: '3',
    //   airportName: 'OHare International Airport',
    //   departureCity: 'Chicago',
    //   arrivalCity: 'San Francisco',
    //   departureStateCode: 'IL',
    //   arrivalStateCode: 'CA',
    //   departureDate: DateTime(2022, 12, 1, 9, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 12, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 21000.00,
    //   airwayName: 'United Airlines',
    //   airplaneName: 'Boeing 777',
    // ),
    // PlaneTicket(
    //   id: '4',
    //   airportName: 'Dallas/Fort Worth International Airport',
    //   departureCity: 'Dallas',
    //   arrivalCity: 'New York City',
    //   departureStateCode: 'TX',
    //   arrivalStateCode: 'NY',
    //   departureDate: DateTime(2022, 12, 1, 7, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 10, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 19000.00,
    //   airwayName: 'Southwest Airlines',
    //   airplaneName: 'Boeing 737',
    // ),
    // PlaneTicket(
    //   id: '5',
    //   airportName: 'Seattle-Tacoma International Airport',
    //   departureCity: 'Seattle',
    //   arrivalCity: 'Denver',
    //   departureStateCode: 'WA',
    //   arrivalStateCode: 'CO',
    //   departureDate: DateTime(2022, 12, 1, 12, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 15, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 18000.00,
    //   airwayName: 'Alaska Airlines',
    //   airplaneName: 'Airbus A321',
    // ),
    // PlaneTicket(
    //   id: '6',
    //   airportName: 'Miami International Airport',
    //   departureCity: 'Miami',
    //   arrivalCity: 'Chicago',
    //   departureStateCode: 'FL',
    //   arrivalStateCode: 'IL',
    //   departureDate: DateTime(2022, 12, 1, 6, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 9, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 22000.00,
    //   airwayName: 'JetBlue Airways',
    //   airplaneName: 'Embraer E190',
    // ),
    // PlaneTicket(
    //   id: '7',
    //   airportName: 'San Francisco International Airport',
    //   departureCity: 'San Francisco',
    //   arrivalCity: 'Seattle',
    //   departureStateCode: 'CA',
    //   arrivalStateCode: 'WA',
    //   departureDate: DateTime(2022, 12, 1, 11, 0).toIso8601String(),
    //   arrivalDate: DateTime(2022, 12, 1, 14, 0).toIso8601String(),
    //   travelTime: 180,
    //   price: 20000.00,
    //   airwayName: 'Delta Airlines',
    //   airplaneName: 'Boeing 737',
    // )
  ];

  List<PlaneTicket> _allPlaneTicketItems = [];

  List<PlaneTicket> get planeTicketItems {
    return [..._planeTicketItems];
  }

  OrderTicket get latestTicket {
    return _latestTicket;
  }

  List<PlaneTicket> get allPlaneTicketItems {
    return [..._allPlaneTicketItems];
  }

  Future<void> fetchPopularTickets() async {
    final url = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/popularTickets.json');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<PlaneTicket> loadedTicket = [];
    extractedData.forEach((tickID, tickValue) {
      loadedTicket.add(PlaneTicket(
        id: tickID.toString(),
        airportName: tickValue['airportName'],
        departureCity: tickValue['departureCity'],
        arrivalCity: tickValue['arrivalCity'],
        departureStateCode: tickValue['departureStateCode'],
        arrivalStateCode: tickValue['arrivalStateCode'],
        departureDate: tickValue['departureDate'],
        arrivalDate: tickValue['arrivalDate'],
        travelTime: tickValue['travelTime'],
        price: tickValue['price'],
        airwayName: tickValue['airwayName'],
        airplaneName: tickValue['airplaneName'],
      ));
    });

    _planeTicketItems = loadedTicket;
    notifyListeners();

    // _planeTicketItems.forEach((element) async {
    //   final response = await http.post(url,
    //       body: json.encode({
    //         'airportName': element.airportName,
    //         'departureCity': element.departureCity,
    //         'arrivalCity': element.arrivalCity,
    //         'departureStateCode': element.departureStateCode,
    //         'arrivalStateCode': element.arrivalStateCode,
    //         'departureDate': element.departureDate,
    //         'arrivalDate': element.arrivalDate,
    //         'travelTime': element.travelTime,
    //         'price': element.price,
    //         'airwayName': element.airwayName,
    //         'airplaneName': element.airplaneName,
    //       }));
    // });
  }

  Future<void> fetchAllTickets() async {
    final url = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/popularTickets.json');
    final url2 = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/allTickets.json');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final response2 = await http.get(url2);
    final extractedData2 = json.decode(response2.body) as Map<String, dynamic>;

    final List<PlaneTicket> loadedTicket = [];
    extractedData.forEach((tickID, tickValue) {
      loadedTicket.add(PlaneTicket(
        id: tickID.toString(),
        airportName: tickValue['airportName'],
        departureCity: tickValue['departureCity'],
        arrivalCity: tickValue['arrivalCity'],
        departureStateCode: tickValue['departureStateCode'],
        arrivalStateCode: tickValue['arrivalStateCode'],
        departureDate: tickValue['departureDate'],
        arrivalDate: tickValue['arrivalDate'],
        travelTime: tickValue['travelTime'],
        price: tickValue['price'],
        airwayName: tickValue['airwayName'],
        airplaneName: tickValue['airplaneName'],
      ));
    });

    extractedData2.forEach((tickID, tickValue) {
      loadedTicket.add(PlaneTicket(
        id: tickID.toString(),
        airportName: tickValue['airportName'],
        departureCity: tickValue['departureCity'],
        arrivalCity: tickValue['arrivalCity'],
        departureStateCode: tickValue['departureStateCode'],
        arrivalStateCode: tickValue['arrivalStateCode'],
        departureDate: tickValue['departureDate'],
        arrivalDate: tickValue['arrivalDate'],
        travelTime: tickValue['travelTime'],
        price: tickValue['price'],
        airwayName: tickValue['airwayName'],
        airplaneName: tickValue['airplaneName'],
      ));
    });

    _allPlaneTicketItems = loadedTicket;
    notifyListeners();
    // _planeTicketItems.forEach((element) async {
    //   final response = await http.post(url,
    //       body: json.encode({
    //         'airportName': element.airportName,
    //         'departureCity': element.departureCity,
    //         'arrivalCity': element.arrivalCity,
    //         'departureStateCode': element.departureStateCode,
    //         'arrivalStateCode': element.arrivalStateCode,
    //         'departureDate': element.departureDate,
    //         'arrivalDate': element.arrivalDate,
    //         'travelTime': element.travelTime,
    //         'price': element.price,
    //         'airwayName': element.airwayName,
    //         'airplaneName': element.airplaneName,
    //       }));
    // });
  }

  Future<void> latestTicketFetcher(String uid) async {
    final url = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/users/${uid}/orders/latestTicket.json');
    await http.get(url).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        final latestTicket = OrderTicket(
          orderId: value['orderId'],
          ticket: value['ticket'],
          userId: value['userId'],
          countPassengers: value['countPassengers'],
          totalPrice: value['totalPrice'],
          classType: value['classType'],
          packageType: value['packageType'],
        );
        _latestTicket = latestTicket;
        notifyListeners();
      });
    });
  }

  Future<void> boughtTicket(
      {required String uid,
      required String orderId,
      required String ticket,
      required int countPassengers,
      required double totalPrice,
      required String classType,
      required String packageType}) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/$uid/orders/latestTicket");
      await ref.remove();
    } catch (e) {
      print(e);
    } finally {
      final url = Uri.parse(
          'https://personal-projects-89a44-default-rtdb.firebaseio.com/users/$uid/orders/latestTicket.json');
      final urlHistory = Uri.parse(
          'https://personal-projects-89a44-default-rtdb.firebaseio.com/users/$uid/orders/history.json');

      await http.post(
        url,
        body: json.encode({
          'orderId': orderId,
          'ticket': ticket,
          'userId': uid,
          'countPassengers': countPassengers,
          'totalPrice': totalPrice,
          'classType': classType,
          'packageType': packageType
        }),
      );
      await http.post(
        urlHistory,
        body: json.encode({
          'orderId': orderId,
          'ticket': ticket,
          'userId': uid,
          'countPassengers': countPassengers,
          'totalPrice': totalPrice,
          'classType': classType,
          'packageType': packageType
        }),
      );
    }
  }
}
