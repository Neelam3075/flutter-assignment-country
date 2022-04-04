import 'package:flutter/material.dart';

class Utils {
  static Future<T?> showCustomDialog<T>(
      {required BuildContext buildContext, required Widget dialogUi}) async {
    return await showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(26),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: dialogUi,
          );
        });
  }
}
