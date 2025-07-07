import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:pjsk_sticker/pages/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Color(0xFF39C5BB));
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: Color(0xFF39C5BB),
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'PJSK Sticker',
          theme: ThemeData(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          home: AppPage(),
        );
      },
    );
  }
}
