class OrderTicket {
  final String orderId;
  final String ticket;
  final String userId;
  final int countPassengers;
  final double totalPrice;
  final String classType;
  final String packageType;

  OrderTicket({
    required this.orderId,
    required this.ticket,
    required this.userId,
    required this.countPassengers,
    required this.totalPrice,
    required this.classType,
    required this.packageType,
  });
}
