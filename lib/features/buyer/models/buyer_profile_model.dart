import 'package:hive/hive.dart';

part 'buyer_profile_model.g.dart';

@HiveType(typeId: 3)
class BuyerProfileModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String businessName;

  @HiveField(3)
  final String businessType;

  @HiveField(4)
  final String businessAddress;

  @HiveField(5)
  final String businessPhone;

  @HiveField(6)
  final String businessEmail;

  @HiveField(7)
  final String? hederaAccountId;

  @HiveField(8)
  final String? hederaPrivateKey;

  @HiveField(9)
  final double hbarBalance;

  @HiveField(10)
  final List<String> preferredCategories;

  @HiveField(11)
  final String? deliveryAddress;

  @HiveField(12)
  final String? notes;

  @HiveField(13)
  final DateTime createdAt;

  @HiveField(14)
  final DateTime updatedAt;

  @HiveField(15)
  final Map<String, dynamic>? metadata;

  BuyerProfileModel({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.businessAddress,
    required this.businessPhone,
    required this.businessEmail,
    this.hederaAccountId,
    this.hederaPrivateKey,
    this.hbarBalance = 0.0,
    this.preferredCategories = const [],
    this.deliveryAddress,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.metadata,
  });

  factory BuyerProfileModel.fromJson(Map<String, dynamic> json) {
    return BuyerProfileModel(
      id: json['id'],
      userId: json['userId'],
      businessName: json['businessName'],
      businessType: json['businessType'],
      businessAddress: json['businessAddress'],
      businessPhone: json['businessPhone'],
      businessEmail: json['businessEmail'],
      hederaAccountId: json['hederaAccountId'],
      hederaPrivateKey: json['hederaPrivateKey'],
      hbarBalance: json['hbarBalance']?.toDouble() ?? 0.0,
      preferredCategories: List<String>.from(json['preferredCategories'] ?? []),
      deliveryAddress: json['deliveryAddress'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessName': businessName,
      'businessType': businessType,
      'businessAddress': businessAddress,
      'businessPhone': businessPhone,
      'businessEmail': businessEmail,
      'hederaAccountId': hederaAccountId,
      'hederaPrivateKey': hederaPrivateKey,
      'hbarBalance': hbarBalance,
      'preferredCategories': preferredCategories,
      'deliveryAddress': deliveryAddress,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  String get formattedHbarBalance => '${hbarBalance.toStringAsFixed(2)} HBAR';
  bool get hasHederaAccount => hederaAccountId != null && hederaAccountId!.isNotEmpty;
}
