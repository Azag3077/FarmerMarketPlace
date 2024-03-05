import 'package:farmers_marketplace/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api_handler/service.dart';
import '../../router/route.dart';
import '../widgets/app_bar.dart';
import '../widgets/dialogs.dart';
import '../widgets/list_tile.dart';
import '../widgets/snackbar.dart';
import 'auth_pages/welcome_page.dart';
import 'change_password_page.dart';

final _isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _onResetPassword(BuildContext context) {}

  Future<void> _onDeleteAccount(BuildContext context, WidgetRef ref) async {
    // BLOCK USER INTERACTION
    ref.read(_isLoadingProvider.notifier).update((state) => true);

    final id = ref.read(userProvider)!.id;

    apiService.delete(id).then((response) {
      ref.read(_isLoadingProvider.notifier).update((state) => true);
      switch (response.status) {
        case ResponseStatus.pending:
          return;
        case ResponseStatus.success:
          return _onSuccessful(context);
        case ResponseStatus.failed:
          return _onFailed(context, response.message!);
        case ResponseStatus.connectionError:
          return _onConnectionError(context);
        case ResponseStatus.unknownError:
          return _onUnknownError(context);
      }
    });
  }

  void _onSuccessful(BuildContext context) {
    pushToAndClearStack(context, const WelcomePage());
  }

  void _onFailed(BuildContext context, String message) {
    snackbar(
      context: context,
      title: 'Something went wrong',
      message: message,
      contentType: ContentType.failure,
    );
  }

  void _onConnectionError(BuildContext context) {
    const String message =
        'A network connection problem interrupted the process. '
        'Please check your network and try again';
    snackbar(
      context: context,
      title: 'Network error',
      message: message,
      contentType: ContentType.failure,
    );
  }

  void _onUnknownError(BuildContext context) {
    const String message =
        'An unknown server error occurred, please try again. '
        'If error persist, please report to the admin';
    snackbar(
      context: context,
      title: 'Unknown server error',
      message: message,
      contentType: ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: Column(
        children: <Widget>[
          CustomListTile(
            onTap: () => _onResetPassword(context),
            leadingIconData: Icons.lock_reset_rounded,
            title: 'Reset Password',
          ),
          CustomListTile(
            onTap: () => pushTo(context, const ChangePasswordPage()),
            leadingIconData: CupertinoIcons.lock,
            title: 'Change Password',
          ),
          CustomListTile(
            leadingIconData: CupertinoIcons.delete,
            leadingIconColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.error,
            title: 'Delete Account',
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmDialog(
                  title: 'Delete Account',
                  body: 'This action cannot be undone',
                  actionLabel: 'Delete',
                  onAction: () => _onDeleteAccount(context, ref),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
