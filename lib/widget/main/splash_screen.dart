import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/widget/auth/AuthWidget.dart';
import 'package:test_flutter/widget/mainMenu/MainMenuWidget.dart';
import 'package:test_flutter/widget/mainMenu/test_nav.dart';
import 'package:test_flutter/widget/profile_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: GetIt.I<AuthRepository>().is_auth(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Пока данные загружаются, показываем загрузочный индикатор или экран загрузки
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            // В случае ошибки можно перенаправить пользователя на определенный экран ошибки
            return const AuthWidget();
          } else {
            final bool isAuthenticate = snapshot.requireData;
            if (!isAuthenticate) {
              // Если auth_token отсутствует, перенаправляем пользователя на экран авторизации
              return const AuthWidget();
            } else {
              // Если auth_token есть, перенаправляем пользователя на главный экран
              return ProfileWidget();
            }
          }
        }
      },
    );
  }
}
