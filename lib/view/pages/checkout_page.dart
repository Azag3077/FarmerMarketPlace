import 'package:farmers_marketplace/core/extensions/double.dart';
import 'package:farmers_marketplace/main.dart';
import 'package:farmers_marketplace/view/pages/addresses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import '../widgets/app_bar.dart';
import '../widgets/buttons.dart';

class CheckoutPage extends ConsumerWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Checkout',
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Delivery address',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Username'),
                              const SizedBox(height: 4.0),
                              Text(
                                'User address',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 15.0),
                              const Text('User Phone number'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: Colors.grey.shade100,
                          ),
                          child: IconButton(
                            onPressed: () =>
                                pushTo(context, const AddressesPage()),
                            style: IconButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Order Items',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1.2,
                      ),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: carts.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.grey.shade200),
                      itemBuilder: (BuildContext context, int index) {
                        final cart = carts.elementAt(index);

                        return Row(
                          children: <Widget>[
                            SizedBox.square(
                              dimension: 33.0,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: const CircleBorder(),
                                  color: Colors.blue.withOpacity(.3),
                                ),
                                child: Center(
                                    child: Text(
                                  '${cart.cartCount}x',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(child: Text(cart.name)),
                            Text((cart.price * cart.cartCount).toPrice()),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.2,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  spreadRadius: -5.0,
                  blurRadius: 10.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Subtotal',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        carts
                            .map((c) => c.price * c.cartCount)
                            .reduce((a, b) => a + b)
                            .toPrice(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Shipping fee',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        500.0.toPrice(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        (carts
                                    .map((c) => c.price * c.cartCount)
                                    .reduce((a, b) => a + b) +
                                500)
                            .toPrice(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 8.0,
                ),
                const SizedBox(height: 8.0),
                CustomButton(
                  onPressed: () {},
                  text: 'Complete order',
                  margin: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
