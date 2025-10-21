class Buyer {
  final int userId;
  final String? companyName;
  final String? businessType;
  final String? businessAddress;
  final String? businessPhone;
  final String? businessEmail;
  final String? deliveryAddress;
  final bool? hasHederaAccount;
  final String? hederaAccountId;
  final double? hbarBalance;
  final List<String>? preferredCategories;

  Buyer({
    required this.userId,
    this.companyName,
    this.businessType,
    this.businessAddress,
    this.businessPhone,
    this.businessEmail,
    this.deliveryAddress,
    this.hasHederaAccount,
    this.hederaAccountId,
    this.hbarBalance,
    this.preferredCategories,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        userId: json['user_id'] ?? json['userId'],
        companyName: json['company_name'] ?? json['companyName'],
        businessType: json['business_type'] ?? json['businessType'],
        businessAddress: json['business_address'] ?? json['businessAddress'],
        businessPhone: json['business_phone'] ?? json['businessPhone'],
        businessEmail: json['business_email'] ?? json['businessEmail'],
        deliveryAddress: json['delivery_address'] ?? json['deliveryAddress'],
        hasHederaAccount: json['has_hedera_account'] ?? false,
        hederaAccountId: json['hedera_account_id'] ?? json['hederaAccountId'],
        hbarBalance: json['hbar_balance'] != null
            ? double.tryParse('${json['hbar_balance']}')
            : null,
        preferredCategories: (json['preferred_categories'] is List)
            ? List<String>.from(json['preferred_categories'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'company_name': companyName,
        'business_type': businessType,
        'business_address': businessAddress,
        'business_phone': businessPhone,
        'business_email': businessEmail,
        'delivery_address': deliveryAddress,
        'has_hedera_account': hasHederaAccount,
        'hedera_account_id': hederaAccountId,
        'hbar_balance': hbarBalance,
        'preferred_categories': preferredCategories,
      };

  // Backwards-compatible getters used by feature UI
  String get businessName => companyName ?? '';

  /// Preferred categories placeholder (feature expects a list)
  List<String> get preferredCategoriesSafe => preferredCategories ?? [];

  /// Hedera helpers (placeholders until real integration)
  String get formattedHbarBalance => '${hbarBalance?.toStringAsFixed(2) ?? '0.00'} HBAR';
  bool get hasHederaAccountSafe => hasHederaAccount ?? false;
}
