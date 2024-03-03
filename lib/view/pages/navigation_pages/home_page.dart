import 'package:farmers_marketplace/main.dart';
import 'package:farmers_marketplace/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller.dart';
import '../../../core/constants/assets.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/card.dart';
import '../../widgets/text_fields.dart';
import '../details_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final carts = ref.watch(cartsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 0.0,
        toolbarHeight: 72.0,
        leading: const SizedBox.shrink(),
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hi User',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'Get the best farm produce right to you doorstep',
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CustomSearchbar(
              margin: EdgeInsets.all(15),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              hintText: 'Search...',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Row(
                      children: <Widget>[
                        Text('See all'),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CategoryContainerButton(
                  onPressed: () {},
                  image: AppImages.fruits,
                  text: 'Soup & Ingredients',
                ),
                CategoryContainerButton(
                  onPressed: () {},
                  image: AppImages.broccoli,
                  text: 'Grains',
                ),
                CategoryContainerButton(
                  onPressed: () {},
                  image: AppImages.broccoli,
                  text: 'Foodstuffs',
                ),
                CategoryContainerButton(
                  onPressed: () {},
                  image: AppImages.broccoli,
                  text: 'Fruits',
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
              child: Text(
                'Top Rated Products',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.separated(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 6.0,
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 15.0),
                itemBuilder: (BuildContext context, int index) {
                  final product = products.elementAt(index);
                  final heroTag = '${product.image}$index';
                  final cartIds = carts.where((p) => p.id == product.id);
                  final count = cartIds.isEmpty ? 0 : cartIds.first.cartCount;

                  return ProductCard(
                    onPressed: () => pushTo(context,
                        DetailsPage(product: product, heroTag: heroTag)),
                    onIncrement: () =>
                        onCartIncrement(context, ref, product.id, true),
                    onDecrement: () =>
                        onCartIncrement(context, ref, product.id, false),
                    heroTag: '${product.image}$index',
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    rating: product.rating,
                    count: count,
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
              child: Text(
                'Latest Products',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              padding: const EdgeInsets.all(15.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        AppImages.fruits,
                        color: Colors.green,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, top: 30.0, bottom: 5.0),
              child: Text(
                'Trending Products',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              padding: const EdgeInsets.all(15.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        AppImages.fruits,
                        color: Colors.green,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryContainerButton extends StatelessWidget {
  const CategoryContainerButton({
    Key? key,
    required this.onPressed,
    required this.image,
    required this.text,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      elevation: 0,
      onPressed: onPressed,
      padding: const EdgeInsets.all(6.0),
      color: Theme.of(context).primaryColor.withOpacity(.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox.square(
        dimension: 60.0,
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset(image, width: 40.0)),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.0),
            ),
          ],
        ),
      ),
    );
  }
}
