import 'package:app/views/screens/login.screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: "Pretendard",
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            shadowColor: Colors.transparent,
          ),
          cardTheme: const CardThemeData(
            elevation: 0.0,
            shadowColor: Colors.transparent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shadowColor: Colors.transparent,
            ),
          ),
          // Add other themes as needed to remove shadows from other Material widgets
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
