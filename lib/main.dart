import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/root_detection/root_detection_screen.dart';
import 'view/search/startsearch_page.dart';
import 'view/home_page/home_page.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        StartSearchPage.id: (context) => const StartSearchPage(),
        HomePage.id: (context) => const HomePage(),
      },
      home: const RootAPP(),
    );
  }
}
