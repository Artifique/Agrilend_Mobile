// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      farmerId: fields[1] as String,
      farmerName: fields[2] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      category: fields[5] as String,
      quantity: fields[6] as double,
      unit: fields[7] as String,
      suggestedPrice: fields[8] as double,
      finalPrice: fields[9] as double,
      harvestDate: fields[10] as DateTime,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      images: (fields[13] as List).cast<String>(),
      isAvailable: fields[14] as bool,
      isVerified: fields[15] as bool,
      metadata: (fields[16] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.farmerId)
      ..writeByte(2)
      ..write(obj.farmerName)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.unit)
      ..writeByte(8)
      ..write(obj.suggestedPrice)
      ..writeByte(9)
      ..write(obj.finalPrice)
      ..writeByte(10)
      ..write(obj.harvestDate)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.images)
      ..writeByte(14)
      ..write(obj.isAvailable)
      ..writeByte(15)
      ..write(obj.isVerified)
      ..writeByte(16)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
