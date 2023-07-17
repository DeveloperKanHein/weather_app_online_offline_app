// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      maxTempC: (json['maxtemp_c'] as num?)?.toDouble(),
      maxTempF: (json['maxtemp_f'] as num?)?.toDouble(),
      minTempC: (json['mintemp_c'] as num?)?.toDouble(),
      minTempF: (json['mintemp_f'] as num?)?.toDouble(),
      condition: json['condition'] == null
          ? null
          : Condition.fromJson(json['condition'] as Map<String, dynamic>),
    )
      ..avgTempC = (json['avgtemp_c'] as num?)?.toDouble()
      ..avgTempF = (json['avgtemp_f'] as num?)?.toDouble();

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'maxtemp_c': instance.maxTempC,
      'maxtemp_f': instance.maxTempF,
      'mintemp_c': instance.minTempC,
      'mintemp_f': instance.minTempF,
      'avgtemp_c': instance.avgTempC,
      'avgtemp_f': instance.avgTempF,
      'condition': instance.condition,
    };
