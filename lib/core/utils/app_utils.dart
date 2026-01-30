import 'dart:math';

class AppUtils {
  static String generateDeviceId() {
    // TODO: Generate unique device ID for simulation
    return 'device_${Random().nextInt(10000)}';
  }

  static String formatBytes(List<int> bytes) {
    // TODO: Format bytes to hex string
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
  }

  static String formatTimestamp(DateTime timestamp) {
    // TODO: Format timestamp to readable string
    return timestamp.toIso8601String();
  }

  static bool isValidUuid(String uuid) {
    // TODO: Validate UUID format
    return true;
  }

  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}