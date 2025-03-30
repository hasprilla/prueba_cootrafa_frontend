import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String inventoryId;
  final String name;
  final String barcode;
  final String price;
  final int quantity;
  final String createdAt;
  final String updatedAt;
  final Inventario inventario;

  const ProductEntity({
    required this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.inventario,
  });

  @override
  List<Object?> get props => [
    id,
    inventoryId,
    name,
    barcode,
    price,
    quantity,
    createdAt,
    updatedAt,
    inventario,
  ];
}

class Inventario extends Equatable {
  final String id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  const Inventario({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt];
}
