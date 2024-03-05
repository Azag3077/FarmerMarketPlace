import 'package:farmers_marketplace/core/api_handler/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/product.dart';
import 'models/user.dart';

final userProvider = StateProvider<User?>((ref) => null);

final cartsProvider = StateProvider<List<Product>>((ref) => []);

final productsProvider = StateProvider<List<Product>>((ref) => dummyProducts);

// final categoriesProvider = FutureProvider((ref) => apiService.categories());
