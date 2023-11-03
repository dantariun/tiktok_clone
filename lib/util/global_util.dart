import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalUtil {
  textFieldUnFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  pushNavigator(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

  setSystemUiOverlayMode(bool darkOrLight) {
    if (darkOrLight) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }
}

bool isDartMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
