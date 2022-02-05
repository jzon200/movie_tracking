// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMovieAdapter extends TypeAdapter<HiveMovie> {
  @override
  final int typeId = 0;

  @override
  HiveMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMovie(
      id: fields[0] as String?,
      title: fields[1] as String?,
      overview: fields[2] as String?,
      imageUrl: fields[3] as String?,
      director: fields[4] as String?,
      duration: fields[5] as int?,
      rating: fields[6] as double?,
      year: fields[7] as int?,
      genres: (fields[8] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveMovie obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.director)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.year)
      ..writeByte(8)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
