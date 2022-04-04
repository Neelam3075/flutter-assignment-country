// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_by_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryByCodeResponse _$CountryByCodeResponseFromJson(
        Map<String, dynamic> json) =>
    CountryByCodeResponse(
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CountryByCodeResponseToJson(
        CountryByCodeResponse instance) =>
    <String, dynamic>{
      'country': instance.country,
    };
