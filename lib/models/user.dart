class User {
  final int? id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? hederaAccountId;
  final String role;
  final bool? isActive;
  final bool? emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.hederaAccountId,
    required this.role,
    this.isActive,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] is int
            ? json['id']
            : (json['id'] != null ? int.parse('${json['id']}') : null),
        email: json['email'] ?? '',
        firstName: json['first_name'] ?? json['firstName'],
        lastName: json['last_name'] ?? json['lastName'],
        phone: json['phone'],
        address: json['address'],
        hederaAccountId: json['hedera_account_id'] ?? json['hederaAccountId'],
        role: json['role'] ?? 'FARMER',
        isActive: json['is_active'] ?? json['isActive'],
        emailVerified: json['email_verified'] ?? json['emailVerified'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
        'hedera_account_id': hederaAccountId,
        'role': role,
        'is_active': isActive,
        'email_verified': emailVerified,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

extension UserCompat on User {
  /// Feature code expects `userType` string
  String get userType => role.toLowerCase();

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
