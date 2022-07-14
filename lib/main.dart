import 'package:admin_picco/pages/main/main_view.dart';
import 'package:admin_picco/services/main_service.dart';
import 'package:flutter/material.dart';

void main() async {
  await MainService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
      routes: {
        // UserDetailPage.id: (context) => const UserDetailPage(),
      },
    );
  }
}
