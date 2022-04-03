import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:ezcountries/screens/country/country_cubit/country_cubit.dart';
import 'package:ezcountries/src/models/countries_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        Country? country = state.selectedCountry;

        return WillPopScope(
          onWillPop: () {
            context.read<CountryCubit>().selectCountry(null);
            return Future.value(true);
          },
          child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  country?.name ?? '',
                  style: countryDetailsAppBarStyle,
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                  child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(mainAxisSize: MainAxisSize.max
                          ,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    Center(
                      child: Text(
                        country?.emoji ?? '',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.7),
                      ),
                    ),

                    Row(
                      children: [
                        const Text(
                          Strings.code,
                          style: countryDetailsBodyStyle,
                        ),
                        Text(
                          country?.code ?? '',
                          style: countryDetailsBodyStyle,
                        )
                      ],
                    ),
                            const SizedBox(height: 10,) ,

                            Row(
                      children: [
                        const Text(
                          Strings.capital,
                          style: countryDetailsBodyStyle,
                        ),
                        Text(
                          country?.capital ?? '',
                          style: countryDetailsBodyStyle,
                        )
                      ],
                    ),
                            const SizedBox(height: 10,) ,

                            Row(
                      children: [
                        const Text(
                          Strings.currency,
                          style: countryDetailsBodyStyle,
                        ),
                        Text(
                          country?.currency ?? '',
                          style: countryDetailsBodyStyle,
                        )
                      ],
                    ),
                            const SizedBox(height: 10,) ,

                            const Text(
                      Strings.language,
                      style: countryDetailsBodyStyle,
                    ),
                   const SizedBox(height: 10,) ,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ListView.builder(
                          shrinkWrap: true,

                          itemCount: country?.languages?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Text(
                              country?.languages?[index].name ?? '',
                              style: countryDetailsBodyStyle,
                            );
                          }),
                    ),
                  ])))),
        );
      },
    );
  }
}
