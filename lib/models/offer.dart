class Offer {
  final int? id;
  final int farmerId;
  final int productId;
  final double quantity;
  final String quantityUnit;
  final double suggestedPrice;
  final String status;

  Offer({
    this.id,
    required this.farmerId,
    required this.productId,
    required this.quantity,
    required this.quantityUnit,
    required this.suggestedPrice,
    required this.status,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json['id'] is int
            ? json['id']
            : (json['id'] != null ? int.parse('${json['id']}') : null),
        farmerId: json['farmer_id'] ?? json['farmerId'],
        productId: json['product_id'] ?? json['productId'],
        quantity: json['quantity'] != null
            ? double.parse('${json['quantity']}')
            : 0.0,
        quantityUnit: json['quantity_unit'] ?? json['quantityUnit'] ?? 'KG',
        suggestedPrice: json['suggested_price'] != null
            ? double.parse('${json['suggested_price']}')
            : 0.0,
        status: json['status'] ?? 'DRAFT',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'farmer_id': farmerId,
        'product_id': productId,
        'quantity': quantity,
        'quantity_unit': quantityUnit,
        'suggested_price': suggestedPrice,
        'status': status,
      };
}
