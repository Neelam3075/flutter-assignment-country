import 'package:ezcountries/res/app_colors.dart';
import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:ezcountries/screens/country/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCountryDialogUi extends StatelessWidget {
  SearchCountryDialogUi({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return BlocConsumer<CountryCubit, CountryState>(
      listener: (blocContext, state) {
        if (state.countryResponse?.country != null) {
          Navigator.pop(context, state.countryResponse!.country!);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 280,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    Strings.enterCountryCode,
                    style: dialogHeaderTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.code,
                          textAlign: TextAlign.center,
                          style: dialogHeaderTextStyle,
                        ),
                      ),
                      //      SizedBox(width: 15),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          maxLength: 2,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? Strings.pleaseEnterCountryCode
                                : null;
                          },
                          controller: _searchController,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Z a-z ]')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: ((state.countryResponse != null &&
                            state.countryResponse!.country == null) ||
                        (state.msg != null)),
                    child: Text(
                      (state.msg == null)
                          ? Strings.invalidCountryCode
                          : state.msg ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          color: appColorRed,
                          fontWeight: FontWeight.bold),
                    )),
                Column(
                  children: [
                    Divider(
                        height: 1,
                        thickness: 1,
                        color: appColorGrey.withOpacity(0.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              Strings.cancel,
                              style: dialogHeaderTextStyle,
                            ),
                          ),
                        ),
                        Container(
                            width: 1,
                            height: 60 + 3,
                            color: appColorGrey.withOpacity(0.5)),
                        (state.loading ?? false)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<CountryCubit>()
                                        .getCountryByCode(
                                            countryCode:
                                                _searchController.text.toUpperCase());
                                  }
                                },
                                child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(Strings.search,
                                        style: dialogHeaderTextStyle))),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
