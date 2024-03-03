import 'package:farmers_marketplace/core/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const CustomAppBar(
            toolbarHeight: 56 + 48,
            title: 'My Orders',
            bottom: TabBar(
              tabs: <Tab>[
                Tab(text: 'All'),
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Image.asset(AppImages.orders, width: 200.0),
                  Text(
                    'You have no orders',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Image.asset(AppImages.orders, width: 200.0),
                  Text(
                    'You have no orders',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Image.asset(AppImages.orders, width: 200.0),
                  Text(
                    'You have no orders',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
