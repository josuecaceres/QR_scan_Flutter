import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int selectedMenuOpt = 0;

  set setSelectedMenuOpt(int i) {
    selectedMenuOpt = i;
    notifyListeners();
  }
}
