import 'package:equatable/equatable.dart';

class Mode extends Equatable {
  final String id;
  final String name;
  final String description;
  final ModeType type;
  final bool isLocked;
  final String? requiredPermission;

  const Mode({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.isLocked = false,
    this.requiredPermission,
  });

  @override
  List<Object?> get props => [id, name, type, isLocked];
}

enum ModeType {
  beginner,
  intermediate,
  advanced,
}