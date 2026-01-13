import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> initAllBoxes() async {
    // surveyBox is already opened in survey screen when saving → but we can open all here for safety
    await Hive.openBox('surveyBox');
    await Hive.openBox('foodLogs'); // ← this fixes your crash
    // Add more boxes later: await Hive.openBox('settings'); etc.
  }
}
