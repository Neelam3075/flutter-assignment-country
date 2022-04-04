import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ezcountries/graph_ql/gql_queries.dart';
import 'package:ezcountries/graph_ql/graphql_repo.dart';
import 'package:ezcountries/models/country_by_code_response.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit({required GraphQlRepo repo})
      : _repo = repo,
        super(const CountryState()) {}

  final GraphQlRepo _repo;

  getCountryByCode({required String countryCode}) async {
    emit(state.copyWith(loading: true));
    await _repo.callGraphQl(
        GraphQlCallbacks(
          onSuccess: (response) {
            CountryByCodeResponse countryResponse =
                CountryByCodeResponse.fromJson(response);
            emit(state.copyWith(
                countryResponse: countryResponse,
                isSuccess: true,
                loading: false));
          },
          onFail: (error) {
            emit(state.copyWith(msg: error, isSuccess: false, loading: false));
          },
        ),
        query: queryCountry,
        variable: {'code': countryCode});
  }
}
