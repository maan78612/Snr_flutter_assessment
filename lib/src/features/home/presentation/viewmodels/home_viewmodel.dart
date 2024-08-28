import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/repositories/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  bool _isLoading = false;
  TabBarEnum selectedTab = TabBarEnum.recharge;

  bool get isLoading => _isLoading;

  /// Sets the loading state and notifies listeners.
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Updates the selected tab and notifies listeners if the selection changes.
  void setTabView(TabBarEnum type) {
    if (selectedTab != type) {
      selectedTab = type;
      notifyListeners();
    }
  }

  /// Resets the month if the saved month is not the current month.
  /// This includes resetting the user's remaining balance and their beneficiaries' balances.
  Future<void> resetMonth(WidgetRef ref) async {
    final String? changeMonth = _isCurrentMonth(ref);
    if (changeMonth != null) {
      try {
        setLoading(true);
        final body = {"currentMonth": changeMonth};
        await _homeRepository.resetBalances(body: body);
        SnackBarUtils.show(
          "Balances updated successfully",
          SnackBarType.success,
        );
      } catch (_) {
        SnackBarUtils.show(
          "Not able to reset balances. Try after some time.",
          SnackBarType.error,
        );
      } finally {
        setLoading(false);
      }
    }
  }

  /// Checks if the saved month in the user attributes is the current month.
  String? _isCurrentMonth(WidgetRef ref) {
    DateTime now = DateTime.now();
    String actualCurrentMonth = DateFormat('MM-yyyy').format(now);

    print("actualCurrentMonth = $actualCurrentMonth");
    print("user.currentMonth = ${ref.read(userModelProvider).currentMonth}");
    if (ref.read(userModelProvider).currentMonth != actualCurrentMonth) {
      return actualCurrentMonth;
    }
    return null;
  }
}
