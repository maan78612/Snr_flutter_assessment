import 'package:flutter/material.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
class HomeViewModel with ChangeNotifier {
  TabBarEnum selectedTab = TabBarEnum.recharge;

  void setTabView(TabBarEnum type) {
    if (selectedTab != type) {
      selectedTab = type;
      notifyListeners();
    }
  }
}
