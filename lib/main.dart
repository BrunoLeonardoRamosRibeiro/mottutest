import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mottu/bindings/global.binding.dart';
import 'package:mottu/ui/home.page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumo de Api com Kotlin e Method Channel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: GlobalBindings(),
      home: HomePage(),
    );
  }
}
