import 'package:equatable/equatable.dart';
import '../../domain/entities/mode.dart';

/// UI state model for the mode selector screen.
///
/// This model represents the presentation layer state and is separate
/// from business logic to maintain clean architecture boundaries.
class ModeSelectorUiState extends Equatable {
  final List<Mode> availableModes;
  final String? selectedModeId;
  final ModeSelectorStatus status;
  final String? errorMessage;

  const ModeSelectorUiState({
    required this.availableModes,
    this.selectedModeId,
    this.status = ModeSelectorStatus.loading,
    this.errorMessage,
  });

  /// Initial state with loading
  const ModeSelectorUiState.initial()
      : availableModes = const [],
        selectedModeId = null,
        status = ModeSelectorStatus.loading,
        errorMessage = null;

  /// Copy with method for immutable state updates
  ModeSelectorUiState copyWith({
    List<Mode>? availableModes,
    String? selectedModeId,
    ModeSelectorStatus? status,
    String? errorMessage,
  }) {
    return ModeSelectorUiState(
      availableModes: availableModes ?? this.availableModes,
      selectedModeId: selectedModeId ?? this.selectedModeId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Get currently selected mode
  Mode? get selectedMode =>
      selectedModeId != null
          ? availableModes.firstWhere(
              (mode) => mode.id == selectedModeId,
              orElse: () => throw StateError('Selected mode not found'),
            )
          : null;

  /// Check if a mode is currently selected
  bool isModeSelected(String modeId) => selectedModeId == modeId;

  @override
  List<Object?> get props => [
        availableModes,
        selectedModeId,
        status,
        errorMessage,
      ];
}

/// Status enum for UI state management
enum ModeSelectorStatus {
  loading,
  success,
  error,
  empty,
}