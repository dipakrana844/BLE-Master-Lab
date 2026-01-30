import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/mode.dart';

class GetAvailableModesUseCase {
  List<Mode> call() {
    // TODO: Implement logic to get available modes based on user permissions
    return [
      const Mode(
        id: 'beginner',
        name: 'Beginner Mode',
        description: 'Basic BLE scanning and connection',
        type: ModeType.beginner,
      ),
      const Mode(
        id: 'intermediate',
        name: 'Intermediate Mode',
        description: 'Advanced GATT operations and data analysis',
        type: ModeType.intermediate,
      ),
      const Mode(
        id: 'advanced',
        name: 'Advanced Mode',
        description: 'Full BLE protocol control and OTA updates',
        type: ModeType.advanced,
        isLocked: true,
        requiredPermission: 'admin_access',
      ),
    ];
  }
}

final getAvailableModesProvider = Provider<GetAvailableModesUseCase>((ref) {
  return GetAvailableModesUseCase();
});