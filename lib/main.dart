import 'package:flutter/material.dart';
import 'package:tankerwala/core/theme/app_theme.dart';
import 'package:tankerwala/features/auth/screens/sign_in_screen.dart';

void main() {
  runApp(const TankerWalaApp());
}

class TankerWalaApp extends StatelessWidget {
  const TankerWalaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TankerWala',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SignInScreen(),
    );
  }
}