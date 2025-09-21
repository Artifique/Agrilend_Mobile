// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 2;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      id: fields[0] as String,
      buyerId: fields[1] as String,
      farmerId: fields[2] as String,
      productId: fields[3] as String,
      productName: fields[4] as String,
      farmerName: fields[5] as String,
      quantity: fields[6] as double,
      unit: fields[7] as String,
      unitPrice: fields[8] as double,
      totalPrice: fields[9] as double,
      status: fields[10] as OrderStatus,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      escrowDate: fields[13] as DateTime?,
      releaseDate: fields[14] as DateTime?,
      deliveryDate: fields[15] as DateTime?,
      hederaTransactionId: fields[16] as String?,
      deliveryAddress: fields[17] as String?,
      notes: fields[18] as String?,
      metadata: (fields[19] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buyerId)
      ..writeByte(2)
      ..write(obj.farmerId)
      ..writeByte(3)
      ..write(obj.productId)
      ..writeByte(4)
      ..write(obj.productName)
      ..writeByte(5)
      ..write(obj.farmerName)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.unit)
      ..writeByte(8)
      ..write(obj.unitPrice)
      ..writeByte(9)
      ..write(obj.totalPrice)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.escrowDate)
      ..writeByte(14)
      ..write(obj.releaseDate)
      ..writeByte(15)
      ..write(obj.deliveryDate)
      ..writeByte(16)
      ..write(obj.hederaTransactionId)
      ..writeByte(17)
      ..write(obj.deliveryAddress)
      ..writeByte(18)
      ..write(obj.notes)
      ..writeByte(19)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
