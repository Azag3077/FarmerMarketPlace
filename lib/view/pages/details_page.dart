import 'dart:math';
import 'package:farmers_marketplace/core/api_handler/service.dart';
import 'package:farmers_marketplace/core/extensions/double.dart';
import 'package:farmers_marketplace/providers.dart';
import 'package:farmers_marketplace/view/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller.dart';
import '../../router/route.dart';
import '../widgets/buttons.dart';
import '../widgets/card.dart';
import '../widgets/place_holders.dart';
import 'checkout_page.dart';
import 'image_viewer_page.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({
    Key? key,
    required this.heroTag,
    required this.prodId,
  }) : super(key: key);
  final String heroTag;
  final int prodId;

  void _onLike(BuildContext context, WidgetRef ref) {
    final user = ref.read(userFutureProvider).value;

    if (user == null) {
      controller.showMustLoginDialog(
        context,
        'Sorry, you need to be logged in before you can like a product.',
      );
      return;
    }

    ref.read(isLikedProvider(prodId).notifier).update((isLiked) {
      ref.read(likeCountProvider(prodId).notifier).update((count) {
        return count + (!isLiked ? 1 : -1);
      });
      return !isLiked;
    });

    apiService
        .like(prodId, user.id)
        .then((response) => _checkResponse(context, ref, response));
  }

  void _checkResponse(BuildContext context, WidgetRef ref, Response response) {
    if (response.status == ResponseStatus.success) {
      controller.showToast(response.message!);
    } else {
      ref.read(isLikedProvider(prodId).notifier).update((isLiked) {
        ref.read(likeCountProvider(prodId).notifier).update((count) {
          return count + (!isLiked ? 1 : -1);
        });
        return !isLiked;
      });
      snackbar(
        context: context,
        title: 'Failed',
        message: response.message ?? 'Failed to perform request',
        contentType: ContentType.failure,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedProductsFuture = ref.watch(relatedProductsFutureProvider);
    final product = ref.watch(selectedProductProvider(prodId));
    final isLiked = ref.watch(isLikedProvider(prodId));
    final likeCount = ref.watch(likeCountProvider(prodId));

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
                    ImageViewerPage(product: product, heroTag: heroTag),
                  ),
                  padding: EdgeInsets.zero,
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
                          padding: const EdgeInsets.only(
                            top: 35.0,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${product.name}'
                                              '${product.weight > 0 ? ' (${product.weight}${product.unit})' : ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!,
                                            ),
                                          ),
                                          ...List.generate(
                                            5,
                                            (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Icon(
                                                  product.rating > index
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
                                      const SizedBox(height: 5.0),
                                      Text(
                                        product.price.toPrice(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 4.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(.3),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Text(
                                                '${product.quantity} item${product.quantity > 1 ? 's' : ''} in stock'),
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
                                              '$likeCount ${likeCount > 1 ? 'people' : 'person'}'
                                              ' liked this product',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(color: Colors.grey.shade300),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        'Description',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(product.description),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 30.0, bottom: 5.0),
                                  child: Text(
                                    'Related Products',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 260.0,
                                  child: relatedProductsFuture.when(
                                    data: (products) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: min(10, products.length),
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: 6.0,
                                        ),
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 15.0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final product =
                                              products.elementAt(index);
                                          final heroTag =
                                              '${product.image}-DetailsPage(Related)-$index';

                                          return ProductCard(
                                            width: 150,
                                            onPressed: () => controller
                                                .gotToProductDetailsPage(
                                                    context,
                                                    ref,
                                                    product.id,
                                                    heroTag),
                                            onIncrement: () => onCartIncrement(
                                                context, ref, product, true),
                                            onDecrement: () => onCartIncrement(
                                                context, ref, product, false),
                                            heroTag: heroTag,
                                            image: product.image,
                                            name: product.name,
                                            price: product.price,
                                            rating: product.rating,
                                            count: product.cartCount,
                                            weight: product.weight,
                                            unit: product.unit,
                                          );
                                        },
                                      );
                                    },
                                    error: (_, __) {
                                      return Container(
                                        color: Colors.grey.shade300,
                                        width: double.infinity,
                                        margin: const EdgeInsets.all(15.0),
                                        child: Text(_.toString()),
                                      );
                                    },
                                    loading: () {
                                      return ListView.separated(
                                        itemCount: 5,
                                        scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: 6.0,
                                        ),
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 15.0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const ProductCardLoader();
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
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
                            if (product.cartCount > 0) ...[
                              IconButton(
                                onPressed: () => onCartIncrement(
                                    context, ref, product, false),
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
                              Text(product.cartCount.toString()),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: () => onCartIncrement(
                                    context, ref, product, true),
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
                                      context, ref, product, true),
                                  text: 'Add to cart',
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
                  child: LikeButton(
                    isLiked: isLiked,
                    onPressed: () {
                      _onLike(context, ref);
                    },
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

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
  });
  final bool isLiked;
  final VoidCallback onPressed;

  @override
  LikeButtonDemoState createState() => LikeButtonDemoState();
}

class LikeButtonDemoState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _liked = false;

  @override
  void initState() {
    _liked = widget.isLiked;
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // _animationController.reset();
        // _animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    _liked = !_liked;
    _animationController.forward();
    widget.onPressed.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: _animation.value,
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
              onPressed: () => _toggleLike(),
              icon: Icon(
                Icons.favorite,
                color: ColorTween(
                  begin: widget.isLiked ? Colors.red : Colors.grey,
                  end: widget.isLiked ? Colors.grey : Colors.red,
                ).animate(_animationController).value!,
                size: 32.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
