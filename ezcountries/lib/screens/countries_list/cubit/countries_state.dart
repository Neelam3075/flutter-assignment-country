part of 'countries_cubit.dart';

class CountriesState extends Equatable {
  final CountriesResponse? countriesResponse;
  final bool? isSuccess;
  final String? msg;
  final bool? loading;
  final String? searchText;
  final List<Country>? filteredList;

  const CountriesState(
      {this.countriesResponse,
      this.loading,
      this.isSuccess,
      this.msg,
      this.filteredList,
      this.searchText});

  @override
  List<Object?> get props =>
      [msg, isSuccess, loading, filteredList, countriesResponse, searchText];

  CountriesState copyWith(
      {CountriesResponse? countriesResponse,
      bool? isSuccess,
      String? msg,
      bool? loading,
      List<Country>? filteredList,
      String? searchText}) {
    return CountriesState(
      searchText: searchText,
      countriesResponse: countriesResponse ?? this.countriesResponse,
      isSuccess: isSuccess ?? this.isSuccess,
      msg: msg ,
      loading: loading ?? this.loading,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}
