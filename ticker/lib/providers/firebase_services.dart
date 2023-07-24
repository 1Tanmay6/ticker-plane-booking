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
  List<PlaneTicket> _planeTicketItems = [];

  List<PlaneTicket> _allPlaneTicketItems = [];

  List<PlaneTicket> _historyPlaneTicketItems = [];

  List<PlaneTicket> get planeTicketItems {
    return [..._planeTicketItems];
  }

  OrderTicket get latestTicket {
    return _latestTicket;
  }

  List<PlaneTicket> get history {
    return [..._historyPlaneTicketItems];
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
  }

  Future<void> latestTicketFetcher(String uid) async {
    final url = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/users/$uid/orders/latestTicket.json');
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

  Future<void> historyFetcher(String uid) async {
    List<OrderTicket> history_unfiltered = [];
    List<PlaneTicket> history = [];
    final url = Uri.parse(
        'https://personal-projects-89a44-default-rtdb.firebaseio.com/users/$uid/orders/history.json');
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
        history_unfiltered.add(latestTicket);
      });

      history_unfiltered.forEach((element) {
        _allPlaneTicketItems.forEach((element2) {
          if (element.ticket == element2.id) {
            history.add(element2);
          }
        });
      });

      print(history_unfiltered);

      _historyPlaneTicketItems = history;

      notifyListeners();
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
