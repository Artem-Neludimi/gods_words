import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gods_words/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.amber,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
