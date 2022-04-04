part of 'country_cubit.dart';

class CountryState extends Equatable {
  final CountryByCodeResponse? countryResponse;
  final bool? isSuccess;
  final String? msg;
  final bool? loading;

  const CountryState({
    this.countryResponse,
    this.loading,
    this.isSuccess,
    this.msg,
  });

  @override
  List<Object?> get props => [
        msg,
        isSuccess,
        loading,
        countryResponse,
      ];

  CountryState copyWith({
    CountryByCodeResponse? countryResponse,
    bool? isSuccess,
    String? msg,
    bool? loading,
  }) {
    return CountryState(
      countryResponse: countryResponse ?? this.countryResponse,
      isSuccess: isSuccess ?? this.isSuccess,
      msg: msg ?? this.msg,
      loading: loading ?? this.loading,
    );
  }
}
