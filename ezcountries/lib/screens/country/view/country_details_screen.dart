import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:ezcountries/src/models/countries_response.dart';
import 'package:flutter/material.dart';

import '../../../feature_response.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountriesResponse res = CountriesResponse.fromJson(featureCountryResponse);
    res.data?.countries.sort((countryA, countryB) {
      return countryA.name!
          .toLowerCase()
          .compareTo(countryB.name!.toLowerCase());
    });
    Country? country = res.data?.countries[1];
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            country?.name ?? '',
            style: countryDetailsAppBarStyle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Center(
                child: Text(
                  country?.emoji ?? '',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 14, top: 8),
                child: Row(
                  children: [
                    const Text(
                      Strings.code,
                      style: countryDetailsBodyStyle,
                    ),
                    Text(
                      country?.code ?? '',
                      style: countryDetailsBodyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 14, top: 8),
                child: Row(
                  children: [
                    const Text(
                      Strings.capital,
                      style: countryDetailsBodyStyle,
                    ),
                    Text(
                      country?.capital ?? '',
                      style: countryDetailsBodyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 14, top: 8),
                child: Row(
                  children: [
                    const Text(
                      Strings.currency,
                      style: countryDetailsBodyStyle,
                    ),
                    Text(
                      country?.currency ?? '',
                      style: countryDetailsBodyStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 14, top: 8),
                child: Row(
                  children: [
                    const Text(
                      Strings.language,
                      style: countryDetailsBodyStyle,
                    ),
                    Text(
                      country?.languages?[0].name ?? '',
                      style: countryDetailsBodyStyle,
                    )
                  ],
                ),
              ),
            ]))));
  }
}
