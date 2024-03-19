import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_stream_flutter_app/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       title: 'Sound Stream',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        primaryColor: Colors.black,
        // primarySwatch: Colors.red,
        fontFamily: 'Manrope',
      ),
    
    );
  }
}

