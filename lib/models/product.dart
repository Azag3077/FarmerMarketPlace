import 'package:farmers_marketplace/core/constants/assets.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.cartCount,
    required this.rating,
  });
  final String id;
  final String name;
  final String image;
  final double price;
  final int cartCount;
  final int rating;

  Product copyWith({
    String? name,
    String? image,
    double? price,
    int? cartCount,
    int? rating,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      cartCount: cartCount ?? this.cartCount,
      rating: rating ?? this.rating,
    );
  }
}

final dummyProducts = <Product>[
  Product(
    id: '1',
    name: 'Fresh fruits',
    image: AppImages.fruits,
    price: 500,
    cartCount: 0,
    rating: 3,
  ),
  Product(
    id: '2',
    name: 'Fresh fruits',
    image: AppImages.fruits,
    price: 500,
    cartCount: 0,
    rating: 3,
  ),
  Product(
    id: '3',
    name: 'Fresh fruits',
    image: AppImages.fruits,
    price: 500,
    cartCount: 0,
    rating: 3,
  ),
  Product(
    id: '4',
    name: 'Fresh fruits',
    image: AppImages.fruits,
    price: 500,
    cartCount: 0,
    rating: 3,
  ),
  Product(
    id: '5',
    name: 'Fresh fruits',
    image: AppImages.fruits,
    price: 500,
    cartCount: 0,
    rating: 3,
  ),
];
