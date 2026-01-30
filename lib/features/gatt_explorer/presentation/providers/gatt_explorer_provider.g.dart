// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gatt_explorer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Main provider for GATT Explorer UI state

@ProviderFor(GattExplorer)
final gattExplorerProvider = GattExplorerProvider._();

/// Main provider for GATT Explorer UI state
final class GattExplorerProvider
    extends $NotifierProvider<GattExplorer, GattExplorerUiState> {
  /// Main provider for GATT Explorer UI state
  GattExplorerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gattExplorerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gattExplorerHash();

  @$internal
  @override
  GattExplorer create() => GattExplorer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GattExplorerUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GattExplorerUiState>(value),
    );
  }
}

String _$gattExplorerHash() => r'b4688faf82bd327dc82c4cb595eec7ced6e21d9b';

/// Main provider for GATT Explorer UI state

abstract class _$GattExplorer extends $Notifier<GattExplorerUiState> {
  GattExplorerUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GattExplorerUiState, GattExplorerUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GattExplorerUiState, GattExplorerUiState>,
              GattExplorerUiState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
