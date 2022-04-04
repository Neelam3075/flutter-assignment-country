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

  _getCountries() async {
    emit(state.copyWith(loading: true));
    await _repo.callGraphQl(
        GraphQlCallbacks(onSuccess: (response) {
          CountriesResponse countriesResponse =
              CountriesResponse.fromJson(response);
          emit(state.copyWith(
              countriesResponse: countriesResponse,
              isSuccess: true,
              filteredList: countriesResponse.countries,
              loading: false));
        }, onFail: (error) {
          emit(state.copyWith(msg: error, isSuccess: false, loading: false));
        }),
        query: queryAllCountries);
  }

  filterCountries({String? searchKey}) {
    if (searchKey == null) {
      emit(state.copyWith(filteredList: state.countriesResponse?.countries));
      return;
    }
    var getFilteredList = state.countriesResponse?.countries.where((element) {
      return ((element.name?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false) ||
          (element.capital?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false) ||
          (element.code.toLowerCase().contains(searchKey)));
    }).toList();
    emit(state.copyWith(
        searchText: searchKey,
        filteredList: (searchKey.isEmpty)
            ? state.countriesResponse?.countries
            : getFilteredList));
  }
}
