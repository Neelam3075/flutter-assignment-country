import 'package:ezcountries/res/app_colors.dart';
import 'package:ezcountries/res/strings.dart';
import 'package:ezcountries/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils{
static  showSearchDialog({
    required BuildContext context,
    required VoidCallback onYesClick,
  }) {
    Dialog searchDialog = Dialog(
      insetPadding: const EdgeInsets.all(26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

      child: SizedBox(
        height: 280,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                      ],
                      onChanged: (qty) {},
                      validator: (value) {},
                      onTap: () {},
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            //   SizedBox(height: 30),
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
                    InkWell(
                        onTap: () {},
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
    return showDialog(
        builder: (BuildContext context) {
          return searchDialog;
        },
        context: context);
  }
}

