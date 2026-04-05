import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Safe wrapper for Hive operations with error handling
class SafeHiveHelper {
  /// Safely get a box and show error snackbar if it fails
  static Future<Box<T>?> safeOpenBox<T>(
    BuildContext context,
    String boxName, {
    required String errorMessage,
  }) async {
    try {
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      _showErrorSnackBar(context, errorMessage, error: e.toString());
      return null;
    }
  }

  /// Safely put value to Hive box with error handling
  static Future<bool> safePut(
    BuildContext context,
    Box box,
    dynamic key,
    dynamic value, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await box.put(key, value);
      if (successMessage != null && context.mounted) {
        _showSuccessSnackBar(context, successMessage);
      }
      return true;
    } catch (e) {
      _showErrorSnackBar(
        context,
        errorMessage ?? 'Failed to save data',
        error: e.toString(),
      );
      return false;
    }
  }

  /// Safely add value to Hive box with error handling
  static Future<bool> safeAdd(
    BuildContext context,
    Box box,
    dynamic value, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await box.add(value);
      if (successMessage != null && context.mounted) {
        _showSuccessSnackBar(context, successMessage);
      }
      return true;
    } catch (e) {
      _showErrorSnackBar(
        context,
        errorMessage ?? 'Failed to save data',
        error: e.toString(),
      );
      return false;
    }
  }

  /// Safely delete from Hive box with error handling
  static Future<bool> safeDelete(
    BuildContext context,
    Box box,
    dynamic key, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await box.delete(key);
      if (successMessage != null && context.mounted) {
        _showSuccessSnackBar(context, successMessage);
      }
      return true;
    } catch (e) {
      _showErrorSnackBar(
        context,
        errorMessage ?? 'Failed to delete data',
        error: e.toString(),
      );
      return false;
    }
  }

  /// Safely clear entire Hive box with error handling
  static Future<bool> safeClear(
    BuildContext context,
    Box box, {
    String? successMessage,
    String? errorMessage,
  }) async {
    try {
      await box.clear();
      if (successMessage != null && context.mounted) {
        _showSuccessSnackBar(context, successMessage);
      }
      return true;
    } catch (e) {
      _showErrorSnackBar(
        context,
        errorMessage ?? 'Failed to clear data',
        error: e.toString(),
      );
      return false;
    }
  }

  /// Safely get value from Hive box with fallback
  static T safeGet<T>(
    Box box,
    dynamic key,
    T defaultValue, {
    bool debugLog = false,
  }) {
    try {
      final value = box.get(key, defaultValue: defaultValue);
      if (debugLog) {
        debugPrint('SafeHive.get: Retrieved $key = $value');
      }
      return value ?? defaultValue;
    } catch (e) {
      debugPrint('SafeHive.get error for key $key: $e');
      return defaultValue;
    }
  }

  /// Show error snackbar with optional error details
  static void _showErrorSnackBar(
    BuildContext context,
    String message, {
    String? error,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            if (error != null && error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Error: ${error.length > 60 ? "${error.substring(0, 60)}..." : error}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success snackbar
  static void _showSuccessSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show info/warning snackbar
  static void showInfoSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Safely execute async operation with error handling
  static Future<T?> safeExecute<T>(
    BuildContext context,
    Future<T> Function() operation, {
    String? errorMessage,
  }) async {
    try {
      return await operation();
    } catch (e) {
      _showErrorSnackBar(
        context,
        errorMessage ?? 'An error occurred',
        error: e.toString(),
      );
      return null;
    }
  }
}
