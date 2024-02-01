import 'package:expenses_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.indigoAccent);
final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]).then((value) {
    runApp(
        MaterialApp(
          darkTheme: ThemeData.dark().copyWith(
              colorScheme: kDarkColorScheme,

              cardTheme: const CardTheme().copyWith (
                  color: kDarkColorScheme.secondaryContainer,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
              ),

              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkColorScheme.primaryContainer,
                      foregroundColor: kDarkColorScheme.onPrimaryContainer
                  )
              ),

              textTheme: ThemeData.dark().textTheme.copyWith(
                  titleLarge: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kDarkColorScheme.onSecondaryContainer
                  )
              )
          ),

          theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                foregroundColor: kColorScheme.primaryContainer,
                backgroundColor: kColorScheme.onPrimaryContainer
            ),

            cardTheme: const CardTheme().copyWith (
                color: kColorScheme.secondaryContainer,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
            ),

            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorScheme.primaryContainer
                )
            ),

            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kColorScheme.onSecondaryContainer
                )
            ),
          ),

          themeMode: ThemeMode.system,
          home: const Expenses(),
        )
    );
  });
}

