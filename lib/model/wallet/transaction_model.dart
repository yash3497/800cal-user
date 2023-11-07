class TransactionModel {
  final String id;
  final Map customers;
  final num amount;
  final bool debited;
  final num timestamp;
  final String description;

  TransactionModel(
      {required this.id,
      required this.customers,
      required this.amount,
      required this.debited,
      required this.timestamp,
      required this.description});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['_id'],
        customers: json['customers'],
        amount: json['amount'],
        debited: json['debited'],
        timestamp: json['time_stamp'],
        description: json['description']);
  }

  Map<String, dynamic> tojson() {
    return {
      "_id": id,
      "customers": customers,
      "amount": amount,
      "debited": debited,
      "time_stamp": timestamp,
      "description": description,
    };
  }
}
