part of 'country_cubit.dart';

class CountryState extends Equatable {
  final CountriesResponse? countriesResponse;
  final bool? isSuccess;

  final String? msg;

  final bool? loading;
  final String? searchText;

  final List<Country>? filteredList;
  final Country? selectedCountry;

  const CountryState(
      {this.countriesResponse,
      this.loading,
      this.isSuccess,
      this.msg,
      this.filteredList,
      this.selectedCountry,
      this.searchText});

  @override
  List<Object?> get props => [
        msg,
        isSuccess,
        loading,
        filteredList,
        countriesResponse,
        selectedCountry,
        searchText
      ];

  CountryState copyWith(
      {Country? selectedCountry,
      CountriesResponse? countriesResponse,
      bool? isSuccess,
      String? msg,
      bool? loading,
      List<Country>? filteredList,
      String? searchText}) {
    return CountryState(
      searchText: searchText,
      selectedCountry: selectedCountry,
      countriesResponse: countriesResponse ?? this.countriesResponse,
      isSuccess: isSuccess ?? this.isSuccess,
      msg: msg ?? this.msg,
      loading: loading ?? this.loading,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}
