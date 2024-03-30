import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../widgets/place_holders.dart';

class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({
    Key? key,
    required this.product,
    required this.heroTag,
  }) : super(key: key);
  final Product product;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: Text(
          product.name,
          maxLines: 2,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: heroTag,
          child: ImageLoader(
            imageUrl: product.image,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(),
          ),
        ),
      ),
    );
  }
}
