import 'package:ezcountries/graph_ql/graphql_repo.dart';
import 'package:ezcountries/screens/countries_list/cubit/countries_cubit.dart';
import 'package:ezcountries/screens/countries_list/view/countries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GraphQlRepo(),
      child: BlocProvider<CountriesCubit>(
        create: (context) =>
            CountriesCubit(repo: RepositoryProvider.of<GraphQlRepo>(context)),
        child: const CountriesPage(),
      ),
    );
  }
}
