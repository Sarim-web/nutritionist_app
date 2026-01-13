import 'package:flutter/foundation.dart';

class OnboardingProvider extends ChangeNotifier {
  bool _seen = false;
  bool get seen => _seen;

  void markSeen() {
    _seen = true;
    notifyListeners();
  }
}
