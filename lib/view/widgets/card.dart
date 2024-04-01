import 'package:farmers_marketplace/core/extensions/double.dart';
import 'package:farmers_marketplace/view/widgets/place_holders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.onPressed,
    required this.onIncrement,
    required this.onDecrement,
    required this.heroTag,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.count,
    required this.weight,
    required this.unit,
    this.width,
  }) : super(key: key);
  final VoidCallback onPressed;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String heroTag;
  final String image;
  final String name;
  final double price;
  final int rating;
  final int count;
  final double? width;
  final double weight;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(4.0),
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag,
              child: ImageLoader(
                imageUrl: image,
                width: 150,
                height: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 6.0),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '$name ',
                style: Theme.of(context).textTheme.titleSmall,
                children: <InlineSpan>[
                  TextSpan(
                    text: weight > 0 ? '($weight$unit)' : '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.blueGrey.shade600,
                        ),
                  )
                ],
              ),
            ),
            Text(price.toPrice()),
            Row(
              children: List.generate(
                5,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(
                      rating > index
                          ? CupertinoIcons.star_fill
                          : CupertinoIcons.star,
                      size: 12.0,
                      color: Colors.amber.shade700,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            if (count > 0)
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: onDecrement,
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        CupertinoIcons.minus_circle,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                    Text(count.toString()),
                    IconButton(
                      onPressed: onIncrement,
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              )
            else
              ElevatedButton(
                onPressed: onIncrement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  disabledBackgroundColor:
                      Theme.of(context).primaryColor.withOpacity(.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(double.infinity, 34.0),
                ),
                child: const Text('Add to cart'),
              ),
          ],
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.heroTag,
    required this.weight,
    required this.unit,
    required this.price,
    required this.qty,
    required this.onPressed,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);
  final String imageUrl;
  final String name;
  final String heroTag;
  final double weight;
  final String unit;
  final double price;
  final int qty;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(4.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: <Widget>[
          Hero(
            tag: heroTag,
            child: ImageLoader(
              imageUrl: imageUrl,
              width: 100.0,
              height: 100.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Weight: $weight $unit',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        price.toPrice(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    IconButton(
                      onPressed: onDecrement,
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        CupertinoIcons.minus_circle,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(qty.toString()),
                    const SizedBox(width: 4.0),
                    IconButton(
                      onPressed: onIncrement,
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4.0),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: Theme.of(context).primaryColor,
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
  }
}

class SearchProductCard extends StatelessWidget {
  const SearchProductCard({
    Key? key,
    required this.onPressed,
    required this.imageUrl,
    required this.name,
    required this.heroTag,
    required this.search,
    required this.rating,
    required this.price,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String imageUrl;
  final String name;
  final String heroTag;
  final String search;
  final int rating;
  final double price;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    name.splitMapJoin(
      RegExp(search, caseSensitive: false),
      onMatch: (match) {
        textSpans.add(
          TextSpan(
            text: match.group(0),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        );
        return '';
      },
      onNonMatch: (nonMatch) {
        textSpans.add(
          TextSpan(
            text: nonMatch,
          ),
        );
        return '';
      },
    );

    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      padding: const EdgeInsets.all(6.0),
      height: 120.0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: <Widget>[
          Hero(
            tag: heroTag,
            child: ImageLoader(
              imageUrl: imageUrl,
              width: 100.0,
              height: 100.0,
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium,
                    children: textSpans,
                  ),
                ),
                Text(
                  price.toPrice(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(
                          rating > index
                              ? CupertinoIcons.star_fill
                              : CupertinoIcons.star,
                          size: 12.0,
                          color: Colors.amber.shade700,
                        ),
                      );
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

class ProductCardLoader extends StatelessWidget {
  const ProductCardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 150,
      child: Column(
        children: <Widget>[
          Expanded(
            child: DataLoader(),
          ),
          DataLoader(
            height: 15.0,
            margin: EdgeInsets.only(right: 10.0, top: 8.0),
          ),
          DataLoader(
            height: 10.0,
            margin: EdgeInsets.only(right: 60.0, top: 8.0),
          ),
          DataLoader(
            height: 10.0,
            margin: EdgeInsets.only(right: 100.0, top: 8.0),
          ),
          DataLoader(
            height: 34.0,
            radius: 17.0,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          ),
        ],
      ),
    );
  }
}
