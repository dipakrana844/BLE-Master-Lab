// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gatt_explorer_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GattExplorerUiState {

/// Connected device information
 String get deviceName; String get latency;/// Connection status
 bool get isConnected;/// Services data
 List<GattService> get services;/// Loading state
 bool get isLoading;/// Error message if any
 String? get errorMessage;/// Currently selected characteristic for write operations
 GattCharacteristic? get selectedCharacteristic;/// Write panel visibility
 bool get isWritePanelVisible;
/// Create a copy of GattExplorerUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GattExplorerUiStateCopyWith<GattExplorerUiState> get copyWith => _$GattExplorerUiStateCopyWithImpl<GattExplorerUiState>(this as GattExplorerUiState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GattExplorerUiState&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.latency, latency) || other.latency == latency)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCharacteristic, selectedCharacteristic) || other.selectedCharacteristic == selectedCharacteristic)&&(identical(other.isWritePanelVisible, isWritePanelVisible) || other.isWritePanelVisible == isWritePanelVisible));
}


@override
int get hashCode => Object.hash(runtimeType,deviceName,latency,isConnected,const DeepCollectionEquality().hash(services),isLoading,errorMessage,selectedCharacteristic,isWritePanelVisible);

@override
String toString() {
  return 'GattExplorerUiState(deviceName: $deviceName, latency: $latency, isConnected: $isConnected, services: $services, isLoading: $isLoading, errorMessage: $errorMessage, selectedCharacteristic: $selectedCharacteristic, isWritePanelVisible: $isWritePanelVisible)';
}


}

/// @nodoc
abstract mixin class $GattExplorerUiStateCopyWith<$Res>  {
  factory $GattExplorerUiStateCopyWith(GattExplorerUiState value, $Res Function(GattExplorerUiState) _then) = _$GattExplorerUiStateCopyWithImpl;
@useResult
$Res call({
 String deviceName, String latency, bool isConnected, List<GattService> services, bool isLoading, String? errorMessage, GattCharacteristic? selectedCharacteristic, bool isWritePanelVisible
});




}
/// @nodoc
class _$GattExplorerUiStateCopyWithImpl<$Res>
    implements $GattExplorerUiStateCopyWith<$Res> {
  _$GattExplorerUiStateCopyWithImpl(this._self, this._then);

  final GattExplorerUiState _self;
  final $Res Function(GattExplorerUiState) _then;

/// Create a copy of GattExplorerUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceName = null,Object? latency = null,Object? isConnected = null,Object? services = null,Object? isLoading = null,Object? errorMessage = freezed,Object? selectedCharacteristic = freezed,Object? isWritePanelVisible = null,}) {
  return _then(_self.copyWith(
deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,latency: null == latency ? _self.latency : latency // ignore: cast_nullable_to_non_nullable
as String,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<GattService>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCharacteristic: freezed == selectedCharacteristic ? _self.selectedCharacteristic : selectedCharacteristic // ignore: cast_nullable_to_non_nullable
as GattCharacteristic?,isWritePanelVisible: null == isWritePanelVisible ? _self.isWritePanelVisible : isWritePanelVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GattExplorerUiState].
extension GattExplorerUiStatePatterns on GattExplorerUiState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GattExplorerUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GattExplorerUiState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GattExplorerUiState value)  $default,){
final _that = this;
switch (_that) {
case _GattExplorerUiState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GattExplorerUiState value)?  $default,){
final _that = this;
switch (_that) {
case _GattExplorerUiState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceName,  String latency,  bool isConnected,  List<GattService> services,  bool isLoading,  String? errorMessage,  GattCharacteristic? selectedCharacteristic,  bool isWritePanelVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GattExplorerUiState() when $default != null:
return $default(_that.deviceName,_that.latency,_that.isConnected,_that.services,_that.isLoading,_that.errorMessage,_that.selectedCharacteristic,_that.isWritePanelVisible);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceName,  String latency,  bool isConnected,  List<GattService> services,  bool isLoading,  String? errorMessage,  GattCharacteristic? selectedCharacteristic,  bool isWritePanelVisible)  $default,) {final _that = this;
switch (_that) {
case _GattExplorerUiState():
return $default(_that.deviceName,_that.latency,_that.isConnected,_that.services,_that.isLoading,_that.errorMessage,_that.selectedCharacteristic,_that.isWritePanelVisible);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceName,  String latency,  bool isConnected,  List<GattService> services,  bool isLoading,  String? errorMessage,  GattCharacteristic? selectedCharacteristic,  bool isWritePanelVisible)?  $default,) {final _that = this;
switch (_that) {
case _GattExplorerUiState() when $default != null:
return $default(_that.deviceName,_that.latency,_that.isConnected,_that.services,_that.isLoading,_that.errorMessage,_that.selectedCharacteristic,_that.isWritePanelVisible);case _:
  return null;

}
}

}

/// @nodoc


class _GattExplorerUiState implements GattExplorerUiState {
  const _GattExplorerUiState({this.deviceName = 'Polar H10', this.latency = '12ms', this.isConnected = true, final  List<GattService> services = const [], this.isLoading = false, this.errorMessage, this.selectedCharacteristic, this.isWritePanelVisible = false}): _services = services;
  

/// Connected device information
@override@JsonKey() final  String deviceName;
@override@JsonKey() final  String latency;
/// Connection status
@override@JsonKey() final  bool isConnected;
/// Services data
 final  List<GattService> _services;
/// Services data
@override@JsonKey() List<GattService> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

/// Loading state
@override@JsonKey() final  bool isLoading;
/// Error message if any
@override final  String? errorMessage;
/// Currently selected characteristic for write operations
@override final  GattCharacteristic? selectedCharacteristic;
/// Write panel visibility
@override@JsonKey() final  bool isWritePanelVisible;

/// Create a copy of GattExplorerUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GattExplorerUiStateCopyWith<_GattExplorerUiState> get copyWith => __$GattExplorerUiStateCopyWithImpl<_GattExplorerUiState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GattExplorerUiState&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.latency, latency) || other.latency == latency)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCharacteristic, selectedCharacteristic) || other.selectedCharacteristic == selectedCharacteristic)&&(identical(other.isWritePanelVisible, isWritePanelVisible) || other.isWritePanelVisible == isWritePanelVisible));
}


@override
int get hashCode => Object.hash(runtimeType,deviceName,latency,isConnected,const DeepCollectionEquality().hash(_services),isLoading,errorMessage,selectedCharacteristic,isWritePanelVisible);

@override
String toString() {
  return 'GattExplorerUiState(deviceName: $deviceName, latency: $latency, isConnected: $isConnected, services: $services, isLoading: $isLoading, errorMessage: $errorMessage, selectedCharacteristic: $selectedCharacteristic, isWritePanelVisible: $isWritePanelVisible)';
}


}

/// @nodoc
abstract mixin class _$GattExplorerUiStateCopyWith<$Res> implements $GattExplorerUiStateCopyWith<$Res> {
  factory _$GattExplorerUiStateCopyWith(_GattExplorerUiState value, $Res Function(_GattExplorerUiState) _then) = __$GattExplorerUiStateCopyWithImpl;
@override @useResult
$Res call({
 String deviceName, String latency, bool isConnected, List<GattService> services, bool isLoading, String? errorMessage, GattCharacteristic? selectedCharacteristic, bool isWritePanelVisible
});




}
/// @nodoc
class __$GattExplorerUiStateCopyWithImpl<$Res>
    implements _$GattExplorerUiStateCopyWith<$Res> {
  __$GattExplorerUiStateCopyWithImpl(this._self, this._then);

  final _GattExplorerUiState _self;
  final $Res Function(_GattExplorerUiState) _then;

/// Create a copy of GattExplorerUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceName = null,Object? latency = null,Object? isConnected = null,Object? services = null,Object? isLoading = null,Object? errorMessage = freezed,Object? selectedCharacteristic = freezed,Object? isWritePanelVisible = null,}) {
  return _then(_GattExplorerUiState(
deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,latency: null == latency ? _self.latency : latency // ignore: cast_nullable_to_non_nullable
as String,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<GattService>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCharacteristic: freezed == selectedCharacteristic ? _self.selectedCharacteristic : selectedCharacteristic // ignore: cast_nullable_to_non_nullable
as GattCharacteristic?,isWritePanelVisible: null == isWritePanelVisible ? _self.isWritePanelVisible : isWritePanelVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
