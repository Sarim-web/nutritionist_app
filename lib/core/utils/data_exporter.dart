import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive/hive.dart';

/// Exports user data (survey and food logs) to a CSV file and shares it
Future<void> exportData(String profileId) async {
  final surveyBox = Hive.box('survey_$profileId');
  final foodLogsBox = Hive.box('foodLogs_$profileId');

  final surveyData = surveyBox.toMap();
  final logsData = foodLogsBox.values.toList();

  List<List<dynamic>> csvData = [];
  csvData.add(['Type', 'Key', 'Value']);
  surveyData.forEach((key, value) {
    csvData.add(['survey', key, value]);
  });
  for (var log in logsData) {
    csvData.add(['log', '', log]);
  }

  String csvString = const ListToCsvConverter().convert(csvData);

  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/vitacalo_export_$profileId.csv';
  await File(path).writeAsString(csvString);

  // Correct share method (share_plus ≥ 7.0.0 uses shareXFiles)
  await Share.shareXFiles([XFile(path)], text: 'VitaCalo Data Export');
}

/// Imports user data from a CSV file back into the appropriate Hive boxes
Future<bool> importData(String profileId, String csvPath) async {
  try {
    // Verify file exists
    final file = File(csvPath);
    if (!await file.exists()) {
      print('File does not exist: $csvPath');
      return false;
    }

    final csvString = await file.readAsString();
    List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

    final surveyBox = Hive.box('survey_$profileId');
    final foodLogsBox = Hive.box('foodLogs_$profileId');

    // Skip header row
    for (var i = 1; i < csvData.length; i++) {
      final row = csvData[i];

      if (row.isEmpty) continue;

      final type = row[0]?.toString() ?? '';
      final key = row.length > 1 ? row[1]?.toString() ?? '' : '';
      final value = row.length > 2 ? row[2] : null;

      if (type == 'survey' && key.isNotEmpty) {
        await surveyBox.put(key, value);
      } else if (type == 'log' && value != null) {
        await foodLogsBox.add(value);
      }
    }

    print('Successfully imported data for profile: $profileId');
    return true;
  } catch (e) {
    print('Error importing data: $e');
    return false;
  }
}
