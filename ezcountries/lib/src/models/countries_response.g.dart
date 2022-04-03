// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountriesResponse _$CountriesResponseFromJson(Map<String, dynamic> json) =>
    CountriesResponse(
      data: json['data'] == null
          ? null
          : CountriesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountriesResponseToJson(CountriesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CountriesData _$CountriesDataFromJson(Map<String, dynamic> json) =>
    CountriesData(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountriesDataToJson(CountriesData instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] as String?,
      code: json['code'] as String,
      capital: json['capital'] as String?,
      currency: json['currency'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguagesBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      emoji: json['emoji'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'capital': instance.capital,
      'currency': instance.currency,
      'emoji': instance.emoji,
      'languages': instance.languages,
    };

LanguagesBean _$LanguagesBeanFromJson(Map<String, dynamic> json) =>
    LanguagesBean(
      code: json['code'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LanguagesBeanToJson(LanguagesBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
