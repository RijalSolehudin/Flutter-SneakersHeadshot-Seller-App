import 'package:image_picker/image_picker.dart';

class AddProductRequestModel {
  final int categoryId;
  final String name;
  final String description;
  final int price;
  final int stock;
  XFile image;

  AddProductRequestModel(
      {required this.name,
      required this.categoryId,
      required this.description,
      required this.price,
      required this.stock,
      required this.image});

  Map<String, String> toMap() {
    return {
      'category_id': categoryId.toString(),
      'name': name,
      'description': description,
      'price': price.toString(),
      'stock': stock.toString(),
    };
  }
}
