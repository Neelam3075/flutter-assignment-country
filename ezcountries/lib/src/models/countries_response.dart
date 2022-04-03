import 'package:json_annotation/json_annotation.dart';

part 'countries_response.g.dart';

@JsonSerializable()
class CountriesResponse {
  CountriesData? data;

  CountriesResponse({this.data});

  factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesResponseToJson(this);
}

@JsonSerializable()
class CountriesData {
  List<Country> countries;

  CountriesData({required this.countries});

  factory CountriesData.fromJson(Map<String, dynamic> json) =>
      _$CountriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesDataToJson(this);
}

@JsonSerializable()
class Country {
  String? name;
  String code;
  String? capital;
  String? currency;
  String? emoji;

  List<LanguagesBean>? languages;

  Country(
      {this.name,
      required this.code,
      this.capital,
      this.currency,
      this.languages,
      this.emoji});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class LanguagesBean {
  String code;
  String? name;

  LanguagesBean({required this.code, this.name});

  factory LanguagesBean.fromJson(Map<String, dynamic> json) =>
      _$LanguagesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagesBeanToJson(this);
}
