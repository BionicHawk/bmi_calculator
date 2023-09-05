import "package:bmi_calculator/screens/home_page.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var brightness = MediaQuery.of(context).platformBrightness;
    return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(
          useMaterial3: true,
          brightness: (brightness == Brightness.light)
              ? Brightness.light
              : Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
