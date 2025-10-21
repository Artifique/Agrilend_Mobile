class Order {
  final int? id;
  final int buyerId;
  final int offerId;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String status;
  // optional UI fields
  final String? productName;
  final String? farmerName;
  final DateTime? createdAt;
  final DateTime? deliveryDate;
  final DateTime? escrowDate;
  final String? deliveryAddress;

  Order({
    this.id,
    required this.buyerId,
    required this.offerId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.status,
    this.productName,
    this.farmerName,
    this.createdAt,
    this.deliveryDate,
    this.escrowDate,
    this.deliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] is int
            ? json['id']
            : (json['id'] != null ? int.parse('${json['id']}') : null),
        buyerId: json['buyer_id'] ?? json['buyerId'],
        offerId: json['offer_id'] ?? json['offerId'],
        quantity: json['quantity'] != null
            ? double.parse('${json['quantity']}')
            : 0.0,
        unitPrice: json['unit_price'] != null
            ? double.parse('${json['unit_price']}')
            : 0.0,
        totalPrice: json['total_price'] != null
            ? double.parse('${json['total_price']}')
            : 0.0,
        status: json['status'] ?? 'PENDING',
        productName: json['product_name'] ?? json['productName'],
        farmerName: json['farmer_name'] ?? json['farmerName'],
        createdAt: json['created_at'] != null
            ? DateTime.tryParse('${json['created_at']}')
            : null,
        deliveryDate: json['delivery_date'] != null
            ? DateTime.tryParse('${json['delivery_date']}')
            : null,
        escrowDate: json['escrow_date'] != null
            ? DateTime.tryParse('${json['escrow_date']}')
            : null,
        deliveryAddress: json['delivery_address'] ?? json['deliveryAddress'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'buyer_id': buyerId,
        'offer_id': offerId,
        'quantity': quantity,
        'unit_price': unitPrice,
        'total_price': totalPrice,
        'status': status,
      };

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(0)} FCFA';

  String get formattedQuantity => '${quantity.toStringAsFixed(2)}';

  String get formattedCreatedDate => createdAt != null
      ? '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}'
      : '-';

  // Backwards-compatible helpers
  String get idString => id?.toString() ?? '';
}
