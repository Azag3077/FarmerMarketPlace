import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../router/route.dart';
import '../navigation_pages/main_page.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  String _code = '';

  void _onResend(BuildContext context) {}

  void _onVerify(BuildContext context, [String? code]) {
    if ((code ?? _code).length != 6) {
      debugPrint('Incomplete code');
      return;
    }

    if ((code ?? _code) != '123456') {
      debugPrint('Incorrect code');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Verification Code"),
          content: Text('Code entered is $code'),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2)).then((value) => _onSuccessful());
  }

  void _onSuccessful() {
    pushReplacementTo(context, const NavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Text(
              'Verify your account',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'Please enter the code we just sent to your email',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30.0),
            OtpTextField(
              numberOfFields: 6,
              focusedBorderColor: Theme.of(context).primaryColor,
              autoFocus: true,
              showFieldAsBox: true,
              onSubmit: (String code) => _onVerify(context, code),
              onCodeChanged: (String code) => _code = code,
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Didn\'t get the code?'),
                TextButton(
                  onPressed: () => _onResend(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    minimumSize: Size.zero,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Resend'),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            CustomButton(
              onPressed: () => _onVerify(context),
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
