import 'package:image_picker/image_picker.dart';

class EditProductRequestModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final int price;
  final int stock;
  XFile? image;

  EditProductRequestModel(
      {required this.name,
      required this.id,
      required this.categoryId,
      required this.description,
      required this.price,
      required this.stock,
      required this.image});

  Map<String, String> toMap() {
    return {
      'id': id.toString(),
      'category_id': categoryId.toString(),
      'name': name,
      'description': description,
      'price': price.toString(),
      'stock': stock.toString(),
    };
  }
}
