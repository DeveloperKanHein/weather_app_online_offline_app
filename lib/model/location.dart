import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location{
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "region")
  String? region;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "tz_id")
  String? tzID;
  @JsonKey(name: "localtime")
  String? localtime;
  Location({ this.name, this.region, this.country, this.lat, this.lon, this.tzID, this.localtime});
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}