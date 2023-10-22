import 'package:flutter/cupertino.dart';

import '../Model/thememodel.dart';

class themeprovider extends ChangeNotifier {
  Thememodel theme = Thememodel(isdark: false);
  void changetheme(void n) {
    theme.isdark = !theme.isdark;
    notifyListeners();
  }
}
