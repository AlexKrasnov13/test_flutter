import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/widget/auth/AuthWidget.dart';
import 'package:test_flutter/widget/currency/CurrencyWidget.dart';
import 'package:test_flutter/widget/main/splash_screen.dart';
import 'package:test_flutter/widget/mainMenu/MainMenuWidget.dart';
import 'package:test_flutter/dto/Currency.dart';

var routes = {
  '/': (context) => const SplashScreen(),
  '/menu': (context) => const MainMenuWidget(),
  '/login': (context) => const AuthWidget(),
  '/coin': (context) {
    final Currency currentCurrency =
        ModalRoute.of(context)?.settings.arguments as Currency;
    return CurrencyWidget(currentCurrency: currentCurrency);
  }

};
