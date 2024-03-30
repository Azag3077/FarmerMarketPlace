import 'package:farmers_marketplace/main.dart';
import 'package:farmers_marketplace/view/pages/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller.dart';
import '../../core/constants/assets.dart';
import '../../models/models.dart';
import '../../providers.dart';
import '../widgets/app_bar.dart';
import '../widgets/card.dart';
import '../widgets/text_fields.dart';

final _searchProvider = StateProvider.autoDispose<String>((ref) => '');

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _scrollController = ScrollController();
  final _data = <Product>[];
  final _dataPerPage = 10;
  bool _isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 100) {
      _loadData();
    }
  }

  void _loadData() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      List<String> newData = List.generate(
          _dataPerPage, (index) => 'Item ${_data.length + index + 1}');
      setState(() {
        // _data.addAll(newData);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(_searchProvider);
    final products = ref.watch(productsStateProvider);
    final sorted = products?.where(
        (product) => product.name.toLowerCase().contains(search.toLowerCase()));

    return Scaffold(
      appBar: const CustomAppBar(title: 'Search'),
      body: Column(
        children: <Widget>[
          CustomSearchbar(
            margin: const EdgeInsets.all(15),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            hintText: 'Search...',
            autofocus: true,
            onChanged: (text) =>
                ref.read(_searchProvider.notifier).update((_) => text),
          ),
          if (sorted!.isEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 100.0),
                    Image.asset(
                      AppImages.search,
                      width: 200.0,
                    ),
                    Text(
                      'No result found',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18.0),
                    )
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: sorted.length,
                padding: const EdgeInsets.all(15.0),
                separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                itemBuilder: (BuildContext context, int index) {
                  final product = sorted.elementAt(index);
                  final heroTag = '${product.image}-SearchPage-$index';
                  return SearchProductCard(
                    onPressed: () => controller.gotToProductDetailsPage(
                        context, ref, product, heroTag),
                    search: search,
                    imageUrl: product.image,
                    name: product.name,
                    rating: product.rating,
                    price: product.price,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
