import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileProvider extends ChangeNotifier {
  String _currentProfileId = 'main';

  ProfileProvider() {
    final settings = Hive.box('settings');
    _currentProfileId =
        settings.get('current_profile_id', defaultValue: 'main');
  }

  String get currentProfileId => _currentProfileId;

  Box get surveyBox {
    final boxName = 'survey_$_currentProfileId';
    if (!Hive.isBoxOpen(boxName)) {
      throw Exception(
          'Box $boxName is not open. Make sure it is opened in main()');
    }
    return Hive.box(boxName);
  }

  Box get foodLogsBox {
    final boxName = 'foodLogs_$_currentProfileId';
    if (!Hive.isBoxOpen(boxName)) {
      throw Exception(
          'Box $boxName is not open. Make sure it is opened in main()');
    }
    return Hive.box(boxName);
  }

  Future<void> switchProfile(String newId) async {
    // Ensure the new boxes are open
    final surveyBoxName = 'survey_$newId';
    final foodLogsBoxName = 'foodLogs_$newId';

    if (!Hive.isBoxOpen(surveyBoxName)) {
      await Hive.openBox(surveyBoxName);
    }
    if (!Hive.isBoxOpen(foodLogsBoxName)) {
      await Hive.openBox(foodLogsBoxName);
    }

    _currentProfileId = newId;
    await Hive.box('settings').put('current_profile_id', newId);
    notifyListeners();
  }
}
