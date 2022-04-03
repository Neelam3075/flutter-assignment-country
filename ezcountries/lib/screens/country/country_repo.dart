import 'package:ezcountries/feature_response.dart';
import 'package:ezcountries/src/models/countries_response.dart';

class CountryRepo {
  Future<CountriesResponse?> getCountries(
      Function(bool loading) loading) async {

    CountriesResponse? res;
    loading(true);
    await Future.delayed(const Duration(seconds: 2), () {
      res = CountriesResponse.fromJson(featureCountryResponse);
      loading(false);
    });

    return res;
  }


}