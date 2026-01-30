import 'package:equatable/equatable.dart';

/// Represents a GATT service with its characteristics
class GattService extends Equatable {
  final String id;
  final String name;
  final String uuid;
  final String icon;
  final String iconColor;
  final bool isExpanded;
  final List<GattCharacteristic> characteristics;

  const GattService({
    required this.id,
    required this.name,
    required this.uuid,
    required this.icon,
    required this.iconColor,
    this.isExpanded = false,
    this.characteristics = const [],
  });

  GattService copyWith({
    String? id,
    String? name,
    String? uuid,
    String? icon,
    String? iconColor,
    bool? isExpanded,
    List<GattCharacteristic>? characteristics,
  }) {
    return GattService(
      id: id ?? this.id,
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      isExpanded: isExpanded ?? this.isExpanded,
      characteristics: characteristics ?? this.characteristics,
    );
  }

  @override
  List<Object?> get props => [id, name, uuid, icon, iconColor, isExpanded, characteristics];
}

/// Represents a GATT characteristic with its properties
class GattCharacteristic extends Equatable {
  final String id;
  final String name;
  final String uuid;
  final List<CharacteristicProperty> properties;
  final bool isActive;
  final String? activeStatus;

  const GattCharacteristic({
    required this.id,
    required this.name,
    required this.uuid,
    this.properties = const [],
    this.isActive = false,
    this.activeStatus,
  });

  GattCharacteristic copyWith({
    String? id,
    String? name,
    String? uuid,
    List<CharacteristicProperty>? properties,
    bool? isActive,
    String? activeStatus,
  }) {
    return GattCharacteristic(
      id: id ?? this.id,
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      properties: properties ?? this.properties,
      isActive: isActive ?? this.isActive,
      activeStatus: activeStatus ?? this.activeStatus,
    );
  }

  @override
  List<Object?> get props => [id, name, uuid, properties, isActive, activeStatus];
}

/// GATT characteristic properties
enum CharacteristicProperty {
  read('R'),
  write('W'),
  notify('N'),
  indicate('I');

  final String abbreviation;
  const CharacteristicProperty(this.abbreviation);
}