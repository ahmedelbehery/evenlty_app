import 'package:evenlty_app/common/app_theme.dart';
import 'package:evenlty_app/firebase_options.dart';
import 'package:evenlty_app/screens/home/forget_password_screen.dart';
import 'package:evenlty_app/screens/home/main_layer_screen.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:evenlty_app/screens/new_event/new_event_tab.dart';
import 'package:evenlty_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        MainLayerScreen.routeName: (_) => MainLayerScreen(),
        NewEventTab.routeName: (_) => NewEventTab(),
        ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? LoginScreen.routeName
          : MainLayerScreen.routeName,
    );
  }
}
