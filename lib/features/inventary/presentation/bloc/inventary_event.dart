part of 'inventary_bloc.dart';

sealed class InventaryEvent extends Equatable {
  const InventaryEvent();

  @override
  List<Object> get props => [];
}

class GetInventaryListEvent extends InventaryEvent {}

class CreateInventaryEvent extends InventaryEvent {
  final String id;
  final String name;

  const CreateInventaryEvent({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class UpdateInventaryEvent extends InventaryEvent {
  final String id;
  final String name;
  const UpdateInventaryEvent({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class DeleteInventaryEvent extends InventaryEvent {
  final String id;
  const DeleteInventaryEvent({required this.id});

  @override
  List<Object> get props => [id];
}
