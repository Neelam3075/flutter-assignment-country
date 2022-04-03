import 'package:ezcountries/res/app_colors.dart';
import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:ezcountries/src/models/countries_response.dart';
import 'package:flutter/material.dart';

import '../../../feature_response.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountriesResponse res = CountriesResponse.fromJson(featureCountryResponse);
    res.data?.countries.sort((countryA, countryB) {
      return countryA.name!
          .toLowerCase()
          .compareTo(countryB.name!.toLowerCase());
    });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(Strings.ezCountries),
        ),
        body: Column(

          children: [
       /*     TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: false,

              decoration: InputDecoration(
                prefixIcon: Transform.scale(
                    scale: 0.6,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    )),
                hintText: hintText,
                suffixIcon: isSuffix ?? false
                    ? Transform.scale(
                    scale: 0.6,
                    child: IconButton(
                      padding: const EdgeInsets.all(8),
                      onPressed: () {
                        onSuffixClick!();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.blue,
                        size: SizeConfig.size_36,
                      ),
                    ))
                    : const SizedBox(),
                errorMaxLines: 4,
                contentPadding: EdgeInsets.all(SizeConfig.size_12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.size_25),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.colorPrimary,
                    width: 0.5,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: validator,
              onSaved: onSaved,
              onChanged: onChanged,
              keyboardType: TextInputType.text,
              autocorrect: false,
            ) ,*/
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: res.data?.countries.length ?? 0,
                  itemBuilder: (context, index) {
                    return _getProductsRow(context,
                        res.data?.countries[index] ?? Country(code: 'IN'), index);
                  }),
            ),
          ],
        ));
  }

  Widget _getProductsRow(BuildContext context, Country country, int? index) =>
      GestureDetector(
        onTap: () {},
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
