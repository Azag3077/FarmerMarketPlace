// import 'package:farmers_marketplace/providers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'core/api_handler/service.dart';
// import 'core/constants/storage.dart';
// import 'models/cart.dart';
// import 'models/categories.dart';
// import 'models/product.dart';
// import 'models/user.dart';
//
// class ProductsData {
//   // Your products data model
// }
//
// class TrendingsData {
//   // Your trendings data model
// }
//
// class AppData {
//   AppData({
//     this.user,
//     this.categories = const [],
//     this.products,
//     this.trendings,
//     this.selectedCategory,
//   });
//   final User? user;
//   final List<Category> categories;
//   final Category? selectedCategory;
//   final ProductsData? products;
//   final TrendingsData? trendings;
//
//   AppData copyWith({
//     User? user,
//     List<Category>? categories,
//     ProductsData? products,
//     TrendingsData? trendings,
//     Category? selectedCategory,
//   }) {
//     return AppData(
//       user: user ?? this.user,
//       categories: categories ?? this.categories,
//       products: products ?? this.products,
//       trendings: trendings ?? this.trendings,
//       selectedCategory: selectedCategory ?? this.selectedCategory,
//     );
//   }
// }
//
// class AppDataNotifier extends StateNotifier<AppData> {
//   AppDataNotifier() : super(AppData()) {
//     _initialize();
//   }
//
//   late final int userId;
//
//   Future<void> _initialize() async {
//     final prefs = await SharedPreferences.getInstance();
//     userId = prefs.getInt(StorageKey.userId)!;
//     _getUser();
//     _getCategories();
//   }
//
//   Future<void> _getUser() async {
//     final response = await apiService.getUser(userId);
//
//     if (response.status == ResponseStatus.success) {
//       final user = User.fromJson(response.data!.first);
//
//       state = state.copyWith(user: user);
//     } else {
//       _getUser();
//     }
//   }
//
//   Future<void> _getCategories() async {
//     final response = await apiService.categories();
//
//     if (response.status == ResponseStatus.success) {
//       final categories = response.data
//           .map<Category>((data) => Category.fromJson(data))
//           .toList();
//
//       state = state.copyWith(categories: categories);
//     } else {
//       _getCategories();
//     }
//   }
//
//   Future<void> _getCart() async {
//     final response = await apiService.cart(userId);
//
//     if (response.status == ResponseStatus.success) {
//       final cart =
//           response.data.map<Cart>((data) => Cart.fromJson(data)).toList();
//
//       // state = state.copyWith(cart: cart);
//     } else {
//       _getCategories();
//     }
//   }
//
//   void updateUser({
//     String? firstname,
//     String? lastname,
//     String? email,
//     // String? phone,
//   }) {
//     final user = state.user?.copyWith(
//       firstname: firstname,
//       lastname: lastname,
//       email: email,
//       // phone: phone,
//     );
//     state = state.copyWith(user: user);
//   }
//
//   void updateCart(Product prod, int qty) {
//     // late final List<Cart> cart;
//     print(qty);
//     // if (qty == 0) {
//     //   final index = state.cart.indexWhere((p) => p.id == prod.id);
//     //   cart = <Cart>[
//     //     ...state.cart.sublist(0, index),
//     //     ...state.cart.sublist(index + 1),
//     //   ];
//     // } else if (state.cart.map((p) => p.id).contains(prod.id)) {
//     //   final index = state.cart.indexWhere((p) => p.id == prod.id);
//     //   cart = <Cart>[
//     //     ...state.cart.sublist(0, index),
//     //     // prd,
//     //     ...state.cart.sublist(index + 1),
//     //   ];
//     // } else {
//     //   cart = [...state.cart, Cart.fromProduct(prod)];
//     // }
//     // final cart = state.cart;
//     // state = state.copyWith(cart: []);
//   }
//
//   void selectCategory(Category category) {
//     state = state.copyWith(selectedCategory: category);
//   }
// }
//
// final appDataProvider = StateNotifierProvider<AppDataNotifier, AppData>((ref) {
//   return AppDataNotifier();
// });
//
// final cartFutureProvider = FutureProvider<List<Cart>>((ref) async {
//   final user = ref.read(appDataProvider).user;
//   if (user != null) {
//     final response = await apiService.cart(user.id);
//
//     if (response.status == ResponseStatus.success) {
//       final cart =
//           response.data.map<Cart>((data) => Cart.fromJson(data)).toList();
//       ref.read(cartsProvider.notifier).update((state) => cart);
//
//       print(ref.read(cartsProvider));
//       return cart;
//     }
//   }
//   return [];
// });
