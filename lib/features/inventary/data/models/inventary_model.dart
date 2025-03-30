import '../../domain/entities/inventary_entity.dart';

class InventaryModel extends InventaryEntity {
  const InventaryModel({required super.id, required super.name});

  factory InventaryModel.fromJson(Map<String, dynamic> json) {
    return InventaryModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
