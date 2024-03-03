import 'package:farmers_marketplace/core/constants/assets.dart';
import 'package:farmers_marketplace/core/extensions/string.dart';
import 'package:farmers_marketplace/main.dart';
import 'package:farmers_marketplace/providers.dart';
import 'package:farmers_marketplace/view/widgets/app_bar.dart';
import 'package:farmers_marketplace/view/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller.dart';
import 'checkout_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Cart',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Cart Summary',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Sub total',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  '₦ ${carts.isEmpty ? '₦0.00' : carts.map((c) => c.price * c.cartCount).reduce((a, b) => a + b).toString().formatToPrice}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (carts.isEmpty) ...[
                    const SizedBox(height: 60.0),
                    Image.asset(
                      AppImages.notification,
                      width: 200,
                    ),
                  ] else ...[
                    const SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: carts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20.0),
                      itemBuilder: (BuildContext context, int index) {
                        final product = carts.elementAt(index);

                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Image.asset(product.image, width: 48.0),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              product.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const Text('Weight: 0.6 kg'),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () => onCartIncrement(
                                              context, ref, product.id),
                                          icon: Icon(
                                            CupertinoIcons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            '₦${product.price.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => onCartIncrement(
                                              context, ref, product.id, false),
                                          style: IconButton.styleFrom(
                                            padding: const EdgeInsets.all(4.0),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          icon: Icon(
                                            CupertinoIcons.minus_circle,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(product.cartCount.toString()),
                                        const SizedBox(width: 4.0),
                                        IconButton(
                                          onPressed: () => onCartIncrement(
                                              context, ref, product.id, true),
                                          style: IconButton.styleFrom(
                                            padding: const EdgeInsets.all(4.0),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          icon: Icon(
                                            CupertinoIcons.plus_circle_fill,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
            CustomButton(
              onPressed: carts.isEmpty
                  ? null
                  : () => pushTo(context, const CheckoutPage()),
              text: 'Checkout',
              margin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
