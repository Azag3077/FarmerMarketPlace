import 'package:farmers_marketplace/models/product.dart';
import 'package:farmers_marketplace/view/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/api_handler/service.dart';
import 'providers.dart';
import 'router/route/app_routes.dart';
import 'view/pages/details_page.dart';

Future<void> onCartIncrement(
  BuildContext context,
  WidgetRef ref,
  Product prod, [
  bool? increment,
]) async {
  final user = ref.read(userFutureProvider).value;

  if (user == null) {
    snackbar(
      context: context,
      title: 'Error',
      message: 'Operation can not be performed at the moment, Please try again',
      contentType: ContentType.warning,
    );
    ref.invalidate(userFutureProvider);
    return;
  }

  final cart = ref.read(cartStateProvider);

  if (cart == null) {
    snackbar(
      context: context,
      title: 'Error',
      message: 'Couldn\'t update cart count, Please try again',
      contentType: ContentType.warning,
    );
    ref.invalidate(cartFutureProvider);
    return;
  }

  final count =
      increment == null ? 0 : prod.cartCount + (increment == true ? 1 : -1);

  // ref
  //     .read(productProvider.notifier)
  //     .update((state) => state!.copyWith(cartCount: count));

  int i = -1;
  ref.read(productsStateProvider.notifier).update((state) {
    final index = state!.indexWhere((p) => p.id == prod.id);
    i = index;
    final a = ref.read(productsStateProvider)!.elementAt(i);
    print('Azag23 ${a.cartCount}');
    state = <Product>[
      ...state.sublist(0, index),
      prod.copyWith(cartCount: count),
      ...state.sublist(index + 1),
    ];
    return state;
  });

  late final Response response;
  if (count == 0) {
    response = await apiService.deleteCartProduct(prod.id, user.id);
  } else if (count == 1) {
    response = await apiService.addCartProduct(user.id, prod.id, count);
  } else {
    final action = increment! ? 'plus' : 'minus';
    response = await apiService.updateCartProduct(prod.id, user.id, action);
  }

  if (response.status == ResponseStatus.success) {
    if (count == 0) {
      // ignore: use_build_context_synchronously
      snackbar(
        context: context,
        title: 'Successful',
        message: 'Product successfully remove from cart.',
      );
    } else if (count == 1) {
      // ignore: use_build_context_synchronously
      snackbar(
        context: context,
        title: 'Successful',
        message: 'Product successfully added to cart.',
      );
    }
  }
  ref.invalidate(cartFutureProvider);

  return;

  // final user = ref.read(appDataProvider).user;
  // final carts = ref.read(cartsProvider);
  // final prodId = prod?.id ?? cart!.id;
  // if (!carts.map((e) => e.prodId).contains(prodId)) {
  //   await apiService.updateCart(user!.id, prodId, 1);
  // } else if (increment == null) {
  //   await apiService.updateCart2(prodId, user!.id);
  // } else {
  //   final action = increment ? 'plus' : 'minus';
  //   await apiService.updateCart1(prodId, user!.id, action);
  // }
  // ref.invalidate(cartFutureProvider);

  // if (increment == true) {
  //   final response = await apiService.updateCart(user!.id, prodId, qty);
  // }
  //
  // return;
  //
  // final prodId = prod?.id ?? cart!.id;
  // final qty = prod?.qty ?? cart!.qty;
  //
  // final user = ref.read(appDataProvider).user;
  // final response = await apiService.updateCart(user!.id, prodId, qty);
  //
  // if (response.status == ResponseStatus.success) {
  //   // ref.read(appDataProvider.notifier).updateCart(product, qty);
  //   // ref.invalidate(cartFutureProvider);
  // }
  //
  // if (carts.map((e) => e.prodId).contains(prodId)) {}
  // print(cart);
  //
  // // // final cart = ref.read(cartFutureProvider);
  // // //
  // // // int qty = 0;
  // // //
  // // // if ((cart.value ?? []).map((e) => e.prodId).contains(product.id)) {
  // // //   qty = cart.value!.singleWhere((p) => p.prodId == product.id).qty;
  // // // }
  // // //
  // // // qty = increment == null ? 0 : qty + (increment ? 1 : -1);
  // // //
  // // // final user = ref.read(appDataProvider).user;
  // // // final response = await apiService.updateCart(user!.id, product.id, qty);
  // // //
  // // // if (response.status == ResponseStatus.success) {
  // // //   ref.read(appDataProvider.notifier).updateCart(product, qty);
  // // //   // ref.invalidate(cartFutureProvider);
  // // // }
  // //
  // // // late final Product product;
  // // //
  // // //
  // // // if (ref.read(cartsProvider).map((e) => e.id).contains(prod.id)) {
  // // //   product = ref.read(cartsProvider).singleWhere((p) => p.id == prod.id);
  // // // } else {
  // // //   product = ref.read(productsProvider).singleWhere((p) => p.id == prod.id);
  // // // }
  // // //
  // // // final cartCount =
  // // // increment == null ? 0 : (product.qty??0) + (increment ? 1 : -1);
  // // // final prd = product.copyWith(cartCount: cartCount);
  // // //
  // // // if (cartCount == 0) {
  // // //   ref.read(cartsProvider.notifier).update((state) {
  // // //     final index = state.indexWhere((p) => p.id == prod.id);
  // // //     state = <Product>[
  // // //       ...state.sublist(0, index),
  // // //       ...state.sublist(index + 1),
  // // //     ];
  // // //     return state;
  // // //   });
  // // // } else if (ref.read(cartsProvider).map((p) => p.id).contains(prod.id)) {
  // // //   ref.read(cartsProvider.notifier).update((state) {
  // // //     final index = state.indexWhere((p) => p.id == prod.id);
  // // //     state = <Product>[
  // // //       ...state.sublist(0, index),
  // // //       prd,
  // // //       ...state.sublist(index + 1),
  // // //     ];
  // // //     return state;
  // // //   });
  // // // } else {
  // // //   ref.read(cartsProvider.notifier).update((state) => [...state, prd]);
  // // // }
  // //
  // // final user = ref.read(appDataProvider).user!;
  // //
  // // final prodId = prod?.id ?? cart?.id;
  // // print(ref.read(cartsProvider));
  // // for (var i in ref.read(cartsProvider).map((e) => e).toList()) {
  // //   print('${i.prodId} -- ${i.qty} $prodId');
  // // }
  // // late final Cart product;
  // //
  // // if (ref.read(cartsProvider).map((e) => e.prodId).contains(prodId)) {
  // //   product = ref.read(cartsProvider).singleWhere((p) => p.prodId == prodId);
  // // } else if (prod == null) {
  // //   product = cart!;
  // // } else {
  // //   product = Cart.fromProduct(prod, user.id);
  // // }
  // //
  // // final cartCount = increment == null ? 0 : product.qty + (increment ? 1 : -1);
  // // final prd = product.copyWith(qty: cartCount);
  // //
  // // print('$cartCount, ${prd.qty}');
  // // // return;
  // // if (cartCount == 0) {
  // //   ref.read(cartsProvider.notifier).update((state) {
  // //     final index = state.indexWhere((p) => p.id == prodId);
  // //     state = [
  // //       ...state.sublist(0, index),
  // //       ...state.sublist(index + 1),
  // //     ];
  // //     return state;
  // //   });
  // // } else if (ref.read(cartsProvider).map((p) => p.id).contains(prodId)) {
  // //   ref.read(cartsProvider.notifier).update((state) {
  // //     final index = state.indexWhere((p) => p.id == prodId);
  // //     state = [
  // //       ...state.sublist(0, index),
  // //       prd,
  // //       ...state.sublist(index + 1),
  // //     ];
  // //     return state;
  // //   });
  // // } else {
  // //   ref.read(cartsProvider.notifier).update((state) => [...state, prd]);
  // // }
}

Future<void> onCartIncrementA(
  BuildContext context,
  WidgetRef ref,
  Product prod, [
  bool? increment,
]) async {
  final user = ref.read(userFutureProvider).value!;

  final count =
      increment == null ? 0 : prod.cartCount + (increment == true ? 1 : -1);

  print(count);

  if (count == 1) {}

  // ref.read(cartStateProvider.notifier).update((state) {
  //   final index = state!.indexWhere((p) => p == prod);
  //   state = <Cart>[
  //     ...state.sublist(0, index),
  //     if (count != 0) prod.copyWith(qty: count),
  //     ...state.sublist(index + 1),
  //   ];
  //   return state;
  // });
  //
  // late final Response response;
  // if (count == 0) {
  //   response = await apiService.deleteCartProduct(prod.prodId, user.id);
  // } else if (count == 1) {
  //   response = await apiService.addCartProduct(user.id, prod.prodId, count);
  // } else {
  //   final action = increment! ? 'plus' : 'minus';
  //   response =
  //   await apiService.updateCartProduct(prod.prodId, user.id, action);
  // }
  //
  // if (response.status == ResponseStatus.success) {
  //   if (count == 0) {
  //     // ignore: use_build_context_synchronously
  //     snackbar(
  //       context: context,
  //       title: 'Successful',
  //       message: 'Product successfully remove from cart.',
  //     );
  //   } else if (count == 1) {
  //     // ignore: use_build_context_synchronously
  //     snackbar(
  //       context: context,
  //       title: 'Successful',
  //       message: 'Product successfully added to cart.',
  //     );
  //   }
  // }
}

int productCartCount(WidgetRef ref, Product product) {
  final cart = ref.watch(cartFutureProvider).value;

  if (cart == null) return 0;

  if (!cart.map((c) => c.prodId).contains(product.id)) return 0;

  return cart.singleWhere((c) => c.prodId == product.id).qty;
}

Future<bool> requestOTP(String email, [bool resend = false]) async {
  final response = await apiService.sendOtp(email);

  switch (response.status) {
    case ResponseStatus.pending:
      return await requestOTP(email);
    case ResponseStatus.success:
      return true;
    case ResponseStatus.failed:
      return false;
    case ResponseStatus.connectionError:
      return false;
    case ResponseStatus.unknownError:
      return false;
  }
}

class Controller {
  void onConnectionError(
    BuildContext context, {
    String? title,
    String? message,
    ContentType? contentType,
  }) {
    snackbar(
      context: context,
      title: title ?? 'Network error',
      contentType: ContentType.failure,
      message: message ??
          'A network connection problem interrupted the process. '
              'Please check your network and try again',
    );
  }

  void onUnknownError(
    BuildContext context, {
    String? title,
    String? message,
    ContentType? contentType,
  }) {
    snackbar(
      context: context,
      title: title ?? 'Unknown server error',
      contentType: contentType ?? ContentType.failure,
      message: message ??
          'An unknown server error occurred, please try again. '
              'If error persist, please report to the admin',
    );
  }

  void gotToProductDetailsPage(
    BuildContext context,
    WidgetRef ref,
    Product product,
    String heroTag,
  ) {
    ref.read(productProvider.notifier).update((_) => product);
    pushTo(context, DetailsPage(heroTag: heroTag, product: product));
  }
}

final controller = Controller();
