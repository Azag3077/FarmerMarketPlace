import 'package:farmers_marketplace/core/extensions/double.dart';
import 'package:farmers_marketplace/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller.dart';
import '../../models/product.dart';
import '../../router/route.dart';
import '../widgets/buttons.dart';
import 'checkout_page.dart';
import 'image_viewer_page.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({
    Key? key,
    required this.product,
    required this.heroTag,
  }) : super(key: key);
  final Product product;
  final String heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartsProvider);
    late final Product cartProduct;
    if (carts.isEmpty) {
      cartProduct = product;
    } else {
      cartProduct = carts.singleWhere((p) => p.id == product.id);
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => pushTo(
                      context,
                      ImageViewerPage(
                          image: cartProduct.image, heroTag: heroTag)),
                  padding: EdgeInsets.zero,
                  child: Hero(
                    tag: heroTag,
                    child: Image.asset(
                      cartProduct.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  left: 15.0,
                  top: 32.0,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: Colors.white70,
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                          spreadRadius: -5.0,
                          blurRadius: 10.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => pop(context),
                      padding: EdgeInsets.zero,
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      color: Theme.of(context).primaryColor,
                      icon: const Icon(Icons.chevron_left),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              children: <Widget>[
                Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(top: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text(cartProduct.name)),
                                    ...List.generate(
                                      5,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Icon(
                                            cartProduct.rating > index
                                                ? CupertinoIcons.star_fill
                                                : CupertinoIcons.star,
                                            size: 12.0,
                                            color: Colors.amber.shade700,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Text(cartProduct.price.toPrice()),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(.3),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                          '${cartProduct.cartCount} in stock'),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(.3),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                          '${cartProduct.rating} liked this product'),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey.shade300),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Description',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Text('The very long description'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.of(context).disabledColor,
                              spreadRadius: -5.0,
                              blurRadius: 10.0,
                              offset: const Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            if (cartProduct.cartCount > 0) ...[
                              IconButton(
                                onPressed: () => onCartIncrement(
                                    context, ref, cartProduct.id, false),
                                style: IconButton.styleFrom(
                                  padding: const EdgeInsets.all(4.0),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: Icon(
                                  CupertinoIcons.minus_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text(cartProduct.cartCount.toString()),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: () => onCartIncrement(
                                    context, ref, cartProduct.id, true),
                                style: IconButton.styleFrom(
                                  padding: const EdgeInsets.all(4.0),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: Icon(
                                  CupertinoIcons.plus_circle_fill,
                                  color: Theme.of(context).primaryColor,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: CustomButton(
                                  onPressed: () =>
                                      pushTo(context, const CheckoutPage()),
                                  text: 'Checkout',
                                  margin: EdgeInsets.zero,
                                ),
                              ),
                            ] else
                              Expanded(
                                child: CustomButton(
                                  onPressed: () => onCartIncrement(
                                      context, ref, cartProduct.id, true),
                                  text: 'Add to cartProduct',
                                  margin: EdgeInsets.zero,
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: Colors.white,
                      shadows: <BoxShadow>[
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                          spreadRadius: -5.0,
                          blurRadius: 10.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        CupertinoIcons.suit_heart_fill,
                        color: Colors.grey.shade400,
                        // size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
