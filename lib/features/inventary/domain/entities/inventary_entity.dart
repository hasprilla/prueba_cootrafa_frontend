import 'package:equatable/equatable.dart';

class InventaryEntity extends Equatable {
  final int? id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  const InventaryEntity({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}
