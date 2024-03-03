import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/validators.dart';
import '../../utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/buttons.dart';
import '../widgets/text_fields.dart';

final _isValidatedProvider = StateProvider.autoDispose<bool>((ref) => false);
final _isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    ref.read(_isValidatedProvider.notifier).update((state) => true);
    if (!_formKey.currentState!.validate()) return;
    dismissKeyboard();

    ref.read(_isLoadingProvider.notifier).update((state) => true);

    Future.delayed(const Duration(seconds: 2)).then((value) =>
        ref.read(_isLoadingProvider.notifier).update((state) => true));
  }

  @override
  Widget build(BuildContext context) {
    final isValidated = ref.watch(_isValidatedProvider);
    final isLoading = ref.watch(_isLoadingProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <CustomTextField>[
                  CustomTextField(
                    labelText: 'First Name',
                    controller: _firstnameController,
                    validator: Validator.validateName,
                    isValidated: isValidated,
                  ),
                  CustomTextField(
                    labelText: 'Last Name',
                    controller: _lastnameController,
                    validator: Validator.validateName,
                    isValidated: isValidated,
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    controller: _lastnameController,
                    validator: Validator.validateName,
                    isValidated: isValidated,
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () => _onSave(context),
              isLoading: isLoading,
              text: 'Save changes',
            ),
          ],
        ),
      ),
    );
  }
}
