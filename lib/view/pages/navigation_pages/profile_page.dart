import 'package:farmers_marketplace/core/extensions/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';
import '../../../router/route.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/list_tile.dart';
import '../addresses_page.dart';
import '../auth_pages/welcome_page.dart';
import '../edit_profile.dart';
import '../orders_page.dart';
import '../settings_page.dart';
import '../supports.dart';
import '../terms_and_conditions.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    Key? key,
    this.leadingActionButton,
  }) : super(key: key);
  final VoidCallback? leadingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        leadingActionButton: leadingActionButton,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () => pushTo(context, const EditProfilePage()),
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 15.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${user.firstname.title}'
                                  ' ${user.lastname.title}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  user.email,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color: Colors.grey.shade100,
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              size: 20.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomListTile(
                    onTap: () => pushTo(context, const AddressesPage()),
                    leadingIconData: Icons.location_on_outlined,
                    title: 'My Addresses',
                  ),
                  CustomListTile(
                    onTap: () => pushTo(context, const OrdersPage()),
                    leadingIconData: CupertinoIcons.cart,
                    title: 'My Orders',
                  ),
                  CustomListTile(
                    onTap: () => pushTo(context, const SupportsPage()),
                    leadingIconData: Icons.support_agent_rounded,
                    title: 'Support',
                  ),
                  CustomListTile(
                    onTap: () => pushTo(context, const SettingsPage()),
                    leadingIconData: CupertinoIcons.gear,
                    title: 'Settings',
                  ),
                  CustomListTile(
                    onTap: () => pushTo(context, const TermsAndConditions()),
                    leadingIconData: CupertinoIcons.question_circle,
                    title: 'Terms and conditions',
                  ),
                ],
              ),
            ),
          ),
          CustomListTile(
            onTap: () => pushToAndClearStack(context, const WelcomePage()),
            leadingIconData: Icons.logout_rounded,
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}
