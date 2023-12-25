import 'package:flutter/material.dart';

class MenuBarviewModel with ChangeNotifier {
  Offset offset = Offset(0, 0);
  void setOfset(Offset offset) {
    this.offset = offset;
    notifyListeners();
  }
}
