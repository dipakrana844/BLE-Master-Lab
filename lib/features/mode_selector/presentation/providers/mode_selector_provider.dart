import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mode_selector_ui_state.dart';
import '../../domain/usecases/get_available_modes.dart';

/// Riverpod provider for managing mode selector UI state.
///
/// This provider handles:
/// - Loading available modes from use case
/// - Managing selection state
/// - Handling UI transitions and errors
/// - Providing reactive state updates
final modeSelectorUiStateProvider =
    NotifierProvider<ModeSelectorUiStateNotifier, ModeSelectorUiState>(
  () {
    return ModeSelectorUiStateNotifier();
  },
);

/// State notifier for mode selector UI logic.
///
/// Separates UI concerns from business logic while maintaining
/// clean architecture boundaries.
class ModeSelectorUiStateNotifier extends Notifier<ModeSelectorUiState> {
  late final GetAvailableModesUseCase _getModesUseCase;

  @override
  ModeSelectorUiState build() {
    _getModesUseCase = ref.watch(getAvailableModesProvider);
    _loadModes();
    return const ModeSelectorUiState.initial();
  }

  /// Load available modes from the use case
  Future<void> _loadModes() async {
    try {
      state = state.copyWith(status: ModeSelectorStatus.loading);
      
      // Simulate async loading for better UX
      await Future.delayed(const Duration(milliseconds: 300));
      
      final modes = _getModesUseCase();
      
      state = state.copyWith(
        availableModes: modes,
        status: modes.isEmpty
            ? ModeSelectorStatus.empty
            : ModeSelectorStatus.success,
      );
    } catch (e) {
      // TODO: Add proper error logging
      state = state.copyWith(
        status: ModeSelectorStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Select a mode by ID
  void selectMode(String modeId) {
    // Validate mode exists
    final modeExists = state.availableModes.any((mode) => mode.id == modeId);
    if (!modeExists) return;

    state = state.copyWith(selectedModeId: modeId);
  }

  /// Clear current selection
  void clearSelection() {
    state = state.copyWith(selectedModeId: null);
  }

  /// Retry loading modes after error
  Future<void> retry() async {
    await _loadModes();
  }

  /// Navigate to selected mode (placeholder for future implementation)
  ///
  /// TODO: Integrate with GoRouter for navigation
  void navigateToSelectedMode() {
    if (state.selectedModeId == null) return;
    
    // TODO: Implement navigation logic
    // Example: ref.read(goRouterProvider).push('/ble-scan');
  }
}