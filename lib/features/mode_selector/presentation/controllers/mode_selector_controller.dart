// Legacy controller - deprecated in favor of mode_selector_provider.dart
/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModeSelectorController extends StateNotifier<ModeSelectorState> {
  ModeSelectorController() : super(const ModeSelectorState.initial());

  void selectMode(String modeId) {
    // TODO: Implement mode selection logic
    state = state.copyWith(selectedModeId: modeId);
  }

  void navigateToMode(String modeId) {
    // TODO: Implement navigation to selected mode
    // This will use GoRouter to navigate to the appropriate screen
  }
}

class ModeSelectorState {
  final String? selectedModeId;
  final bool isLoading;

  const ModeSelectorState({
    this.selectedModeId,
    this.isLoading = false,
  });

  const ModeSelectorState.initial()
      : selectedModeId = null,
        isLoading = false;

  ModeSelectorState copyWith({
    String? selectedModeId,
    bool? isLoading,
  }) {
    return ModeSelectorState(
      selectedModeId: selectedModeId ?? this.selectedModeId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final legacyModeSelectorControllerProvider =
    StateNotifierProvider<ModeSelectorController, ModeSelectorState>((ref) {
  return ModeSelectorController();
});
*/