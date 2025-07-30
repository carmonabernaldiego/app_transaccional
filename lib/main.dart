import 'package:flutter/material.dart';
import 'presentation/views/auth/login_page.dart';

void main() {
  runApp(const RxCheckApp());
}

class RxCheckApp extends StatelessWidget {
  const RxCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxCheck',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
