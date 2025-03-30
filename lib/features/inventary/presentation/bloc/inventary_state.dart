part of 'inventary_bloc.dart';

sealed class InventaryState extends Equatable {
  const InventaryState();

  @override
  List<Object> get props => [];
}

class InventaryInitialState extends InventaryState {}

class GetInventaryListLoadingState extends InventaryState {}

class GetInventaryListSuccessState extends InventaryState {
  final List<InventaryEntity> data;
  const GetInventaryListSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class GetInventaryListFailureState extends InventaryState {
  final String message;
  const GetInventaryListFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class CreateInventaryLoadingState extends InventaryState {}

class CreateInventarySuccessState extends InventaryState {}

class CreateInventaryFailureState extends InventaryState {
  final String message;
  const CreateInventaryFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateInventaryLoadingState extends InventaryState {}

class UpdateInventarySuccessState extends InventaryState {}

class UpdateInventaryFailureState extends InventaryState {
  final String message;
  const UpdateInventaryFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteInventaryLoadingState extends InventaryState {}

class DeleteInventarySuccessState extends InventaryState {}

class DeleteInventaryFailureState extends InventaryState {
  final String message;
  const DeleteInventaryFailureState(this.message);

  @override
  List<Object> get props => [message];
}
