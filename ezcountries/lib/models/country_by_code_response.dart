import 'package:json_annotation/json_annotation.dart';

import 'countries_response.dart';

part 'country_by_code_response.g.dart';

@JsonSerializable()
class CountryByCodeResponse {
  Country? country;

  CountryByCodeResponse({this.country});

  factory CountryByCodeResponse.fromJson(Map<String, dynamic> json) => _$CountryByCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountryByCodeResponseToJson(this);
}


