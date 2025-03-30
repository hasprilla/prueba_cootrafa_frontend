import 'package:equatable/equatable.dart';

class InventaryEntity extends Equatable {
  final String id;
  final String name;

  const InventaryEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
