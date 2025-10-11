import 'package:evenlty_app/common/app_theme.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:evenlty_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
      },
      theme: AppTheme.lightTheme,
      initialRoute: LoginScreen.routeName,
    );
  }
}
