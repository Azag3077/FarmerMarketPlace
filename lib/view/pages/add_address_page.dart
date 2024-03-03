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

class AddAddressPage extends ConsumerStatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends ConsumerState<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberOptController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _phoneNumberOptController.dispose();
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
      appBar: const CustomAppBar(
        title: 'Add Address',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    labelText: 'Full Name',
                    controller: _fullNameController,
                    keyboardType: TextInputType.name,
                    validator: Validator.validateName,
                    isValidated: isValidated,
                  ),
                  CustomTextField(
                    labelText: 'Delivery Address',
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    validator: Validator.validateAddress,
                    isValidated: isValidated,
                  ),
                  CustomAzag(
                    labelText: 'State/Region',
                    hintText: 'Select state',
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: Validator.validatePhoneNumber,
                    isValidated: isValidated,
                  ),
                  CustomAzag(
                    labelText: 'City',
                    hintText: 'Select city',
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: Validator.validatePhoneNumber,
                    isValidated: isValidated,
                  ),
                  CustomTextField(
                    labelText: 'Phone Number',
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: Validator.validatePhoneNumber,
                    isValidated: isValidated,
                  ),
                  CustomTextField(
                    labelText: 'Additional Phone Number',
                    required: false,
                    controller: _phoneNumberOptController,
                    keyboardType: TextInputType.phone,
                    validator: Validator.validatePhoneNumber,
                    isValidated: isValidated,
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () => _onSave(context),
              isLoading: isLoading,
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}

class Azag extends StatelessWidget {
  const Azag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return DropdownMenu<String>(
          label: const Text('Select-Mode'),
          width: constraints.maxWidth,
          // controller: _modeController,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            isDense: true,
            isCollapsed: true,
          ),
          dropdownMenuEntries: List.generate(30, (index) => index).map((mode) {
            return DropdownMenuEntry(
              value: 'This is User at index $mode',
              label: 'This is User at index $mode',
            );
          }).toList(),
        );
      },
    );
  }
}
