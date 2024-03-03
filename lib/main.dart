import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view/pages/splash_screen.dart';
export 'router/route/app_routes.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        primaryColor: const Color(0xFF00A46C),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.blueGrey),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
