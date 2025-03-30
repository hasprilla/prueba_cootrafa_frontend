import '../../domain/entities/inventary_entity.dart';

class InventaryModel extends InventaryEntity {
  const InventaryModel({
    super.id,
    required super.name,
    super.createdAt,
    super.updatedAt,
  });

  factory InventaryModel.fromJson(Map<String, dynamic> json) {
    return InventaryModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
