import 'dart:convert';

class AddProductsResponseModel {
  final String? status;
  final String? message;
  final Product? product;

  AddProductsResponseModel({
    this.status,
    this.message,
    this.product,
  });

  factory AddProductsResponseModel.fromJson(String str) =>
      AddProductsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      AddProductsResponseModel(
        status: json["status"],
        message: json["message"],
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "product": product?.toMap(),
      };
}

class Product {
  final int? sellerId;
  final String? categoryId;
  final String? name;
  final String? description;
  final String? price;
  final String? stock;
  final String? image;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Product({
    this.sellerId,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        sellerId: json["seller_id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "seller_id": sellerId,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
