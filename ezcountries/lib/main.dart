import 'package:ezcountries/graph_ql/graphql_repo.dart';
import 'package:ezcountries/screens/countries_list/view/country_list_screen.dart';
import 'package:ezcountries/screens/country/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GraphQlRepo(),
      child: BlocProvider<CountryCubit>(
        create: (context) =>
            CountryCubit(repo: RepositoryProvider.of<GraphQlRepo>(context)),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const CountriesScreen(),
        ),
      ),
    );
  }
}
