import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ezcountries/graph_ql/gql_queries.dart';
import 'package:ezcountries/graph_ql/graphql_repo.dart';
import 'package:ezcountries/src/models/countries_response.dart';
import 'package:ezcountries/src/models/country_by_code_response.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit({required GraphQlRepo repo})
      : _repo = repo,
        super(const CountryState()) {
    _getCountries();
  }

  final GraphQlRepo _repo;

  _getCountries() async {
    await _repo.callGraphQl(
        GraphQlCallbacks(
          onSuccess: (response) {
            CountriesResponse countriesResponse =
                CountriesResponse.fromJson(response);
            emit(state.copyWith(
                countriesResponse: countriesResponse,
                isSuccess: true,
                filteredList: countriesResponse.countries));
          },
          onFail: (error) {
            emit(state.copyWith(msg: error, isSuccess: false));
          },
          onLoading: (loading) {
            emit(state.copyWith(loading: loading));
          },
        ),
        query: queryAllCountries);
  }

  selectCountry(Country? country) {
    emit(state.copyWith(selectedCountry: country));
  }
  getCountryByCode({required String countryCode}) async {
    await _repo.callGraphQl(
        GraphQlCallbacks(
          onSuccess: (response) {
            CountryByCodeResponse countryResponse =
                CountryByCodeResponse.fromJson(response);
            emit(state.copyWith(
              selectedCountry: countryResponse.country,
              isSuccess: true,
            ));
          },
          onFail: (error) {
            emit(state.copyWith(msg: error, isSuccess: false));
          },
          onLoading: (loading) {
            emit(state.copyWith(loading: loading));
          },
        ),
        query: queryCountry,
        variable: {'code': countryCode});
  }

  filterCountries({String? searchKey}) {
    if (searchKey == null) {
      emit(state.copyWith(
          searchText: null, filteredList: state.countriesResponse?.countries));
      return;
    }
    var getFilteredList = state.countriesResponse?.countries
        .where((element) =>
            (element.name!.toUpperCase().contains(searchKey.toUpperCase())))
        .toList();
    emit(state.copyWith(
        searchText: searchKey,
        filteredList: (searchKey.isEmpty)
            ? state.countriesResponse?.countries
            : getFilteredList));
  }
}
