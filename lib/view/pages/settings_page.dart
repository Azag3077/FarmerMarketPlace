import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../router/route.dart';
import '../widgets/app_bar.dart';
import '../widgets/list_tile.dart';
import 'auth_pages/welcome_page.dart';
import 'change_password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _onResetPassword(BuildContext context) {}

  void _onDeleteAccount(BuildContext context) {
    pushToAndClearStack(context, const WelcomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: Column(
        children: <Widget>[
          CustomListTile(
            onTap: () => _onResetPassword(context),
            leadingIconData: Icons.logout_rounded,
            title: 'Reset Password',
          ),
          CustomListTile(
            onTap: () => pushTo(context, const ChangePasswordPage()),
            leadingIconData: Icons.logout_rounded,
            title: 'Change Password',
          ),
          CustomListTile(
            onTap: () => _onDeleteAccount(context),
            leadingIconData: Icons.logout_rounded,
            title: 'Delete Account',
          ),
        ],
      ),
    );
  }
}
