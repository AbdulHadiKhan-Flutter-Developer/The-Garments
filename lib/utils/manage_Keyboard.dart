import 'package:flutter/material.dart';

class ManageKeyboard {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode focusn = FocusScope.of(context);
    if (!focusn.hasPrimaryFocus) {
      focusn.unfocus();
    }
  }
}
