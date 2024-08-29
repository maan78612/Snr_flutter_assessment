import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technical_assessment_flutter/src/core/enums/snackbar_status.dart';
import 'package:technical_assessment_flutter/src/core/enums/tab_bar_enum.dart';
import 'package:technical_assessment_flutter/src/core/utilities/snack_bar.dart';
import 'package:technical_assessment_flutter/src/features/auth/domain/models/user_model.dart';
import 'package:technical_assessment_flutter/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:technical_assessment_flutter/src/features/home/domain/repositories/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  /// Repository for home-related operations
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  /// Loading state to indicate when a process is running
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// The currently selected tab in the home view
  TabBarEnum selectedTab = TabBarEnum.recharge;

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
  Future<void> resetMonth(UserModel user) async {
    final String? changeMonth = _isCurrentMonth(user);
    if (changeMonth != null) {
      try {
        setLoading(true);
        final body = {"currentMonth": changeMonth};

        // Reset balances for the new month
        await _homeRepository.resetBalances(body: body);

        // Show a success message after resetting balances
        SnackBarUtils.show(
          "Monthly limit updated successfully",
          SnackBarType.success,
        );
      } catch (_) {
        // Show an error message if balance reset fails
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
  /// Returns the current month in 'MM-yyyy' format if the saved month is outdated, otherwise returns null.
  String? _isCurrentMonth(UserModel user) {
    DateTime now = DateTime.now();
    String actualCurrentMonth = DateFormat('MM-yyyy').format(now);

    // Check if the user's saved month matches the actual current month
    if (user.currentMonth != actualCurrentMonth) {
      return actualCurrentMonth;
    }
    return null;
  }
}
