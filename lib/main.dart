import 'package:flutter/material.dart';
import 'package:technaid_test/screens/start_page.dart';
import 'package:flutter/services.dart';

void main() {
  //This two lines of code are used to hide the status bar
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technaid Patient List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboarding(title: 'Technaid Patient List'),
    );
  }
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StartPage(),
    );
  }
}
