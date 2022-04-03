import 'dart:developer';

import 'package:ezcountries/res/app_colors.dart';
import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:ezcountries/screens/country/country_cubit/country_cubit.dart';
import 'package:ezcountries/screens/country/view/country_details_screen.dart';
import 'package:ezcountries/src/models/countries_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(Strings.ezCountries),
        ),
        body: BlocConsumer<CountryCubit, CountryState>(
          listener: (context, state) {
            if (state.selectedCountry != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CountryDetailsScreen(),
              ));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: false,
                    controller:(state.searchText?.isEmpty?? true)? TextEditingController(text:  state.searchText): null,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        padding: const EdgeInsets.all(8),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 26,
                        ),
                      ),
                      hintText: Strings.search,
                      suffixIcon:  Visibility(visible: state.searchText?.isNotEmpty?? false,
                        child: IconButton(
                          padding: const EdgeInsets.all(8),
                          onPressed: () {
                            context.read<CountryCubit>().filterCountries(searchKey: null);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: appColorBlack,
                            size: 26,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(
                          color: appColorPrimary,
                          width: 0.5,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      log('on changed value: $value');
                      context
                          .read<CountryCubit>()
                          .filterCountries(searchKey: value.trimLeft());
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                ),
                (state.loading ?? false)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (state.filteredList != null &&
                            state.filteredList!.isNotEmpty)
                        ? Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: state.filteredList?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return _getCountriesRow(
                                      context,
                                      state.filteredList?[index] ??
                                          Country(code: 'IN'),
                                      index);
                                }),
                          )
                        : const Center(
                            child: Text(
                              Strings.noCountriesFound,
                            ),
                          ),
              ],
            );
          },
        ));
  }

  Widget _getCountriesRow(BuildContext context, Country country, int? index) =>
      GestureDetector(
        onTap: () {
          context.read<CountryCubit>().selectCountry(country);
        },
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: appColorPrimary,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )),
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      country.emoji ?? '',
                      style: const TextStyle(fontSize: 50),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(country.name ?? '', style: countryNameTextStyle),
                          const SizedBox(
                            height: 6,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                    text: Strings.code,
                                    style: countryCodeTextStyle),
                                TextSpan(
                                    text: country.code,
                                    style: countryCodeTextStyle),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    const Text(
                                      Strings.capital,
                                      style: countryNameTextStyle,
                                    ),
                                    Flexible(
                                      child: Text(
                                        country.capital ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: countryCodeTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*      Flexible(
                                child: Row(
                                  children: [
                                    const Text(
                                      Strings.currency,
                                      style: countryCodeTextStyle,
                                    ),
                                    Flexible(
                                      child: Text(
                                        country.currency ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: countryCodeTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(
                  color: appColorTransparentGrey.withOpacity(0.5),
                  height: 1,
                  thickness: 1,
                )
              ],
            )),
      );
}
