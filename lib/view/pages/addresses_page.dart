import 'package:farmers_marketplace/core/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../router/route.dart';
import '../widgets/app_bar.dart';
import '../widgets/buttons.dart';
import 'add_address_page.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Address',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40.0),
            Image.asset(AppImages.address, width: 150.0),
            const SizedBox(height: 10.0),
            const Text('No addresses set'),
            const SizedBox(height: 40.0),
            CustomButton(
              onPressed: () => pushTo(context, const AddAddressPage()),
              text: 'Add Address',
            ),
          ],
        ),
      ),
    );
  }
}
