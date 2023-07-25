class PlaneTicket {
  String id;
  String airportName;
  String departureCity;
  String arrivalCity;
  String departureStateCode;
  String arrivalStateCode;
  String departureDate;
  String arrivalDate;
  int travelTime;
  double price;
  String airwayName;
  String airplaneName;

  PlaneTicket({
    required this.id,
    required this.airportName,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureStateCode,
    required this.arrivalStateCode,
    required this.departureDate,
    required this.arrivalDate,
    required this.travelTime,
    required this.price,
    required this.airwayName,
    required this.airplaneName,
  });
}
