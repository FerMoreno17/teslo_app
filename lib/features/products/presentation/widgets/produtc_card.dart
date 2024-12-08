import 'package:flutter/material.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'dart:developer' as developer;

class ProdutcCard extends StatelessWidget {
  final Product product;
  const ProdutcCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageViewer(images: product.images),
        Text(product.title),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ImageViewer extends StatelessWidget {
  final List<String> images;
  const ImageViewer({required this.images});
  @override
  Widget build(BuildContext context) {
    print(images);
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: NetworkImage(images.first),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
      ),
    );
  }
}
