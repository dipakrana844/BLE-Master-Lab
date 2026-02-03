// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzer_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod provider for analyzer UI state

@ProviderFor(AnalyzerStateNotifier)
final analyzerStateProvider = AnalyzerStateNotifierProvider._();

/// Riverpod provider for analyzer UI state
final class AnalyzerStateNotifierProvider
    extends $NotifierProvider<AnalyzerStateNotifier, AnalyzerState> {
  /// Riverpod provider for analyzer UI state
  AnalyzerStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyzerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyzerStateNotifierHash();

  @$internal
  @override
  AnalyzerStateNotifier create() => AnalyzerStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyzerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyzerState>(value),
    );
  }
}

String _$analyzerStateNotifierHash() =>
    r'3bccbe06d871bb0dcfa2d98b1a8b3a63162d123f';

/// Riverpod provider for analyzer UI state

abstract class _$AnalyzerStateNotifier extends $Notifier<AnalyzerState> {
  AnalyzerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AnalyzerState, AnalyzerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnalyzerState, AnalyzerState>,
              AnalyzerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
