class OrderModel {
  final String id;
  final int timestamp;
  final Map customer;
  final int startDate;
  final int endDate;
  final int duration;
  final bool includeFridays;
  final dynamic discount;
  final int subtotal;
  final int shippingCost;
  final int total;
  final Map restaurantCategory;
  final String email;
  final String phone;
  final String name;
  final String address;
  final String paymentStatus;
  final String orderStatus;
  final Map program;
  final Map meals;
  final int v;

  OrderModel({
    required this.id,
    required this.timestamp,
    required this.customer,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.includeFridays,
    required this.discount,
    required this.subtotal,
    required this.shippingCost,
    required this.total,
    required this.restaurantCategory,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
    required this.paymentStatus,
    required this.orderStatus,
    required this.program,
    required this.meals,
    required this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      timestamp: json['timestamp'],
      customer: json['customer'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      duration: json['duration'],
      includeFridays: json['includeFridays'],
      discount: json['discount'],
      subtotal: json['subtotal'],
      shippingCost: json['shippingcost'],
      total: json['total'],
      restaurantCategory: json['restaurantCategory'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      address: json['address'],
      paymentStatus: json['payment_status'],
      orderStatus: json['order_status'],
      program: json['program'],
      meals: json['meals'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['customer'] = this.customer;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['duration'] = this.duration;
    data['includeFridays'] = this.includeFridays;
    data['discount'] = this.discount;
    data['subtotal'] = this.subtotal;
    data['shippingcost'] = this.shippingCost;
    data['total'] = this.total;
    data['restaurantCategory'] = this.restaurantCategory;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['address'] = this.address;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['program'] = this.program;
    data['meals'] = this.meals;
    data['__v'] = this.v;
    return data;
  }
}
