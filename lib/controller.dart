import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/api_handler/service.dart';
import 'models/product.dart';
import 'providers.dart';

void onCartIncrement(
  BuildContext context,
  WidgetRef ref,
  String id, [
  bool? increment,
]) {
  late final Product product;
  if (ref.read(cartsProvider).map((e) => e.id).contains(id)) {
    product = ref.read(cartsProvider).singleWhere((p) => p.id == id);
  } else {
    product = ref.read(productsProvider).singleWhere((p) => p.id == id);
  }

  final cartCount =
      increment == null ? 0 : product.cartCount + (increment ? 1 : -1);
  final prd = product.copyWith(cartCount: cartCount);

  if (cartCount == 0) {
    ref.read(cartsProvider.notifier).update((state) {
      final index = state.indexWhere((p) => p.id == id);
      state = <Product>[
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
      return state;
    });
  } else if (ref.read(cartsProvider).map((p) => p.id).contains(id)) {
    ref.read(cartsProvider.notifier).update((state) {
      final index = state.indexWhere((p) => p.id == id);
      state = <Product>[
        ...state.sublist(0, index),
        prd,
        ...state.sublist(index + 1),
      ];
      return state;
    });
  } else {
    ref.read(cartsProvider.notifier).update((state) => [...state, prd]);
  }
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
