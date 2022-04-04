import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ezcountries/graph_ql/gql_queries.dart';
import 'package:ezcountries/graph_ql/graphql_repo.dart';
import 'package:ezcountries/models/countries_response.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit({required GraphQlRepo repo})
      : _repo = repo,
        super(const CountriesState()) {
    _getCountries();
  }

  final GraphQlRepo _repo;

  List<Country> _sortList(List<Country> countries) {
    countries.sort((countryA, countryB) {
      return countryA.name!
          .toLowerCase()
          .compareTo(countryB.name!.toLowerCase());
    });
    return countries;
  }

  _getCountries() async {
    emit(state.copyWith(loading: true));
    await _repo.callGraphQl(
        GraphQlCallbacks(onSuccess: (response) {
          CountriesResponse countriesResponse =
              CountriesResponse.fromJson(response);
          List<Country> sortedCountryList =
              _sortList(countriesResponse.countries);
          emit(state.copyWith(
              countriesResponse: countriesResponse,
              isSuccess: true,
              filteredList: sortedCountryList,
              loading: false));
        }, onFail: (error) {
          emit(state.copyWith(msg: error, isSuccess: false, loading: false));
        } , ),
        query: queryAllCountries);
  }

  filterCountries({String? searchKey}) {
    List<Country> countryList = _sortList(state.countriesResponse!.countries);
    if (searchKey == null) {
      emit(state.copyWith(filteredList: countryList));
      return;
    }
    var getFilteredList = state.countriesResponse?.countries.where((element) {
      return ((element.name?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false) ||
          (element.capital?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false) ||
          (element.code.toLowerCase().contains(searchKey)));
    }).toList();
    countryList = _sortList(getFilteredList ?? []);
    emit(state.copyWith(
        searchText: searchKey,
        filteredList: (searchKey.isEmpty) ? countryList : countryList));
  }
}
