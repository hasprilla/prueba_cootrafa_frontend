import 'package:prueba_cootrafa_frontend/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.inventoryId,
    required super.name,
    required super.barcode,
    required super.price,
    required super.quantity,
    required super.createdAt,
    required super.updatedAt,
    required super.inventario,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      inventoryId: json['inventory_id'],
      name: json['name'],
      barcode: json['barcode'],
      price: json['price'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      inventario: InventarioModel.fromJson(json['inventario']),
    );
  }
}

class InventarioModel extends Inventario {
  const InventarioModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InventarioModel.fromJson(Map<String, dynamic> json) {
    return InventarioModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
