import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:guzo_go_clone/presentation/date-selector/provider/trip_date_selector_provider.dart';
import 'package:guzo_go_clone/presentation/home/provivder/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:guzo_go_clone/domain/constants/app_theme.dart';
import 'package:guzo_go_clone/presentation/home/screen/home.dart';
import 'presentation/airport/provider/select_airport_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AirportProvider(context: context),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(context: context),
        ),
        ChangeNotifierProvider(
          create: (_) => TripDateProvider(context: context),
        ),
      ],
      child: AdaptiveTheme(
        light: AppTheme().lightTheme(),
        initial: AdaptiveThemeMode.system,
        dark: AppTheme().darkTheme(),
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme,
            darkTheme: darkTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
