// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyerProfileModelAdapter extends TypeAdapter<BuyerProfileModel> {
  @override
  final int typeId = 3;

  @override
  BuyerProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyerProfileModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      businessName: fields[2] as String,
      businessType: fields[3] as String,
      businessAddress: fields[4] as String,
      businessPhone: fields[5] as String,
      businessEmail: fields[6] as String,
      hederaAccountId: fields[7] as String?,
      hederaPrivateKey: fields[8] as String?,
      hbarBalance: fields[9] as double,
      preferredCategories: (fields[10] as List).cast<String>(),
      deliveryAddress: fields[11] as String?,
      notes: fields[12] as String?,
      createdAt: fields[13] as DateTime,
      updatedAt: fields[14] as DateTime,
      metadata: (fields[15] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, BuyerProfileModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.businessName)
      ..writeByte(3)
      ..write(obj.businessType)
      ..writeByte(4)
      ..write(obj.businessAddress)
      ..writeByte(5)
      ..write(obj.businessPhone)
      ..writeByte(6)
      ..write(obj.businessEmail)
      ..writeByte(7)
      ..write(obj.hederaAccountId)
      ..writeByte(8)
      ..write(obj.hederaPrivateKey)
      ..writeByte(9)
      ..write(obj.hbarBalance)
      ..writeByte(10)
      ..write(obj.preferredCategories)
      ..writeByte(11)
      ..write(obj.deliveryAddress)
      ..writeByte(12)
      ..write(obj.notes)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.updatedAt)
      ..writeByte(15)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyerProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
