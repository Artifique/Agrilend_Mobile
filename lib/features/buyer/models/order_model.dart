import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'order_model.g.dart';

enum OrderStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  escrowed,
  @HiveField(2)
  released,
  @HiveField(3)
  inDelivery,
  @HiveField(4)
  delivered,
  @HiveField(5)
  cancelled,
}

@HiveType(typeId: 2)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String buyerId;

  @HiveField(2)
  final String farmerId;

  @HiveField(3)
  final String productId;

  @HiveField(4)
  final String productName;

  @HiveField(5)
  final String farmerName;

  @HiveField(6)
  final double quantity;

  @HiveField(7)
  final String unit;

  @HiveField(8)
  final double unitPrice;

  @HiveField(9)
  final double totalPrice;

  @HiveField(10)
  final OrderStatus status;

  @HiveField(11)
  final DateTime createdAt;

  @HiveField(12)
  final DateTime updatedAt;

  @HiveField(13)
  final DateTime? escrowDate;

  @HiveField(14)
  final DateTime? releaseDate;

  @HiveField(15)
  final DateTime? deliveryDate;

  @HiveField(16)
  final String? hederaTransactionId;

  @HiveField(17)
  final String? deliveryAddress;

  @HiveField(18)
  final String? notes;

  @HiveField(19)
  final Map<String, dynamic>? metadata;

  OrderModel({
    required this.id,
    required this.buyerId,
    required this.farmerId,
    required this.productId,
    required this.productName,
    required this.farmerName,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.escrowDate,
    this.releaseDate,
    this.deliveryDate,
    this.hederaTransactionId,
    this.deliveryAddress,
    this.notes,
    this.metadata,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      buyerId: json['buyerId'],
      farmerId: json['farmerId'],
      productId: json['productId'],
      productName: json['productName'],
      farmerName: json['farmerName'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      unitPrice: json['unitPrice'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      escrowDate: json['escrowDate'] != null ? DateTime.parse(json['escrowDate']) : null,
      releaseDate: json['releaseDate'] != null ? DateTime.parse(json['releaseDate']) : null,
      deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
      hederaTransactionId: json['hederaTransactionId'],
      deliveryAddress: json['deliveryAddress'],
      notes: json['notes'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'farmerId': farmerId,
      'productId': productId,
      'productName': productName,
      'farmerName': farmerName,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'escrowDate': escrowDate?.toIso8601String(),
      'releaseDate': releaseDate?.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'hederaTransactionId': hederaTransactionId,
      'deliveryAddress': deliveryAddress,
      'notes': notes,
      'metadata': metadata,
    };
  }

  String get formattedTotalPrice => '${totalPrice.toStringAsFixed(2)} FCFA';
  String get formattedQuantity => '$quantity $unit';
  String get formattedCreatedDate => '${createdAt.day}/${createdAt.month}/${createdAt.year}';

  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return 'En attente';
      case OrderStatus.escrowed:
        return 'Fonds séquestrés';
      case OrderStatus.released:
        return 'Fonds débloqués';
      case OrderStatus.inDelivery:
        return 'En livraison';
      case OrderStatus.delivered:
        return 'Livré';
      case OrderStatus.cancelled:
        return 'Annulé';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.escrowed:
        return Colors.blue;
      case OrderStatus.released:
        return Colors.green;
      case OrderStatus.inDelivery:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green.shade700;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
