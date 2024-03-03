import 'package:farmers_marketplace/core/extensions/double.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Hero(
              tag: heroTag,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                width: 150,
                height: 120,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
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
          const SizedBox(height: 10.0),
          if (count > 0)
            SizedBox(
              width: 150,
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
                minimumSize: const Size(150, 34.0),
              ),
              child: const Text('Add to cart'),
            ),
        ],
      ),
    );
  }
}
