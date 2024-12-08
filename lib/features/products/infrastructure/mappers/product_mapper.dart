import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        title: json['title'],
        id: json['id'],
        price: double.parse(json['price'].toString()),
        description: json['description'],
        slug: json['slug'],
        stock: json['stock'],
        sizes: List<String>.from(json['sizes'].map((size) => size)),
        gender: json['gender'],
        tags: List<String>.from(json['tags'].map((tag) => tag)),
        images: List<String>.from(json['images'].map((image) =>
            image.startsWith('http')
                ? image
                : '${Enviroment.apiUrl}/files/product/$image')),
        user: UserMapper.userJsonToEntity(json['user']),
      );
}