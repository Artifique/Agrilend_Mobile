import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String farmerId;

  @HiveField(2)
  final String farmerName;

  @HiveField(3)
  final String name;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final double quantity;

  @HiveField(7)
  final String unit;

  @HiveField(8)
  final double suggestedPrice;

  @HiveField(9)
  final double finalPrice;

  @HiveField(10)
  final DateTime harvestDate;

  @HiveField(11)
  final DateTime createdAt;

  @HiveField(12)
  final DateTime updatedAt;

  @HiveField(13)
  final List<String> images;

  @HiveField(14)
  final bool isAvailable;

  @HiveField(15)
  final bool isVerified;

  @HiveField(16)
  final Map<String, dynamic>? metadata;

  ProductModel({
    required this.id,
    required this.farmerId,
    required this.farmerName,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.suggestedPrice,
    required this.finalPrice,
    required this.harvestDate,
    required this.createdAt,
    required this.updatedAt,
    this.images = const [],
    this.isAvailable = true,
    this.isVerified = false,
    this.metadata,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      farmerId: json['farmerId'],
      farmerName: json['farmerName'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      suggestedPrice: json['suggestedPrice'].toDouble(),
      finalPrice: json['finalPrice'].toDouble(),
      harvestDate: DateTime.parse(json['harvestDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: List<String>.from(json['images'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
      isVerified: json['isVerified'] ?? false,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'farmerName': farmerName,
      'name': name,
      'description': description,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'suggestedPrice': suggestedPrice,
      'finalPrice': finalPrice,
      'harvestDate': harvestDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'images': images,
      'isAvailable': isAvailable,
      'isVerified': isVerified,
      'metadata': metadata,
    };
  }

  String get formattedPrice => '${finalPrice.toStringAsFixed(2)} FCFA';
  String get formattedQuantity => '$quantity $unit';
  String get formattedHarvestDate => '${harvestDate.day}/${harvestDate.month}/${harvestDate.year}';
}
