import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class UserInterfaceController extends ChangeNotifier {
  static void initialize() {
    GetIt.instance
        .registerSingleton<UserInterfaceController>(UserInterfaceController());
  }

  // Static getter to access the instance through GetIt
  static UserInterfaceController get instance =>
      GetIt.instance<UserInterfaceController>();

  static UserInterfaceController get I =>
      GetIt.instance<UserInterfaceController>();

  bool recent = true;
  int forceBuilder = 0;

  void forceRebuild() {
    forceBuilder += 1;
    notifyListeners();
  }

  void handleTapRecentButton() {
    recent = true;
    notifyListeners();
  }

  void handleTapAlllButton() {
    recent = false;
    notifyListeners();
  }
}
