import 'package:evenlty_app/event_details.dart';
import 'package:evenlty_app/l10n/app_localizations.dart';
import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/provider/event_provider.dart';
import 'package:evenlty_app/provider/setting_provider.dart';
import 'package:evenlty_app/provider/theme_provider.dart';
import 'package:evenlty_app/provider/user_provider.dart';
import 'package:evenlty_app/screens/home/location_tab/location_tab.dart';
import 'package:evenlty_app/screens/intro_screens.dart';
import 'package:evenlty_app/screens/new_event/event_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evenlty_app/common/app_theme.dart';
import 'package:evenlty_app/firebase_options.dart';
import 'package:evenlty_app/screens/home/forget_password_screen.dart';
import 'package:evenlty_app/screens/home/main_layer_screen.dart';
import 'package:evenlty_app/screens/login_screen.dart';
import 'package:evenlty_app/screens/new_event/new_event_tab.dart';
import 'package:evenlty_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        MainLayerScreen.routeName: (_) => MainLayerScreen(),
        NewEventTab.routeName: (_) => NewEventTab(),
        ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),
        LocationTab.routeName: (_) => const LocationTab(),
        EventDetails.routeName: (context) {
          final event =
              ModalRoute.of(context)!.settings.arguments as EventModel;
          return EventDetails(event: event);
        },
        EditEventTab.routeName: (context) {
          final event =
              ModalRoute.of(context)!.settings.arguments as EventModel;
          return EditEventTab(eventModel: event);
        },
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<SettingProvider>(context).local),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
      initialRoute: OnboardingScreen.routeName,
    );
  }
}
