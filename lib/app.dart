import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/router/router.dart';
import 'package:test_flutter/theme/customTheme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Crypto portal',
        debugShowCheckedModeBanner: false,
        theme: customTheme,
        routes: routes);
  }
}
