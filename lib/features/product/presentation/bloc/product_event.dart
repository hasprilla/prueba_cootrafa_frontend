part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final int inventoryId;
  final String name;
  final String barcode;
  final String price;
  final int quantity;

  const CreateProductEvent({
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [inventoryId, name, barcode, price, quantity];
}

class UpdateProductEvent extends ProductEvent {
  final int id;
  final int inventoryId;
  final String name;
  final String barcode;
  final String price;
  final int quantity;
  const UpdateProductEvent({
    required this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [id, inventoryId, name, barcode, price, quantity];
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}
