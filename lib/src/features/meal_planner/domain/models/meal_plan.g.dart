// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealPlanAdapter extends TypeAdapter<MealPlan> {
  @override
  final int typeId = 1;

  @override
  MealPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealPlan(
      days: (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<int>())),
    );
  }

  @override
  void write(BinaryWriter writer, MealPlan obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
