import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_flutter/exceptions/api_exception.dart';
import 'package:test_flutter/exceptions/result.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/repository/currency_repository.dart';
import '../../dto/Currency.dart';

class MainMenuWidget extends StatefulWidget {
  const MainMenuWidget({super.key});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  List<Currency> currensies = [];
  bool isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 4) {
      _showLogoutDialog();
    } else {
      // Добавьте здесь навигацию для других кнопок
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    var currenciesResult = await GetIt.I<CurrencyRepository>().getCurrencies();
    switch (currenciesResult) {
      case Success<List<Currency>, APIException>():
        setState(() {
          currensies = currenciesResult.value;
          isLoading = false;
        });
      case Failure<List<Currency>, APIException>():
        setState(() {
          isLoading = false;
          _errorMessage = currenciesResult.exception.getMessage();
        });
    }
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Подтверждение выхода"),
          content: const Text("Вы уверены, что хотите выйти?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Отмена"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Выйти"),
              onPressed: () async {
                // Добавьте здесь код для выполнения выхода из аккаунта
                // Например, вызов функции для выхода из аккаунта
                // await GetIt.I<AuthRepository>().logout();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/login");
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: currensies.length,
              itemBuilder: (BuildContext context, int index) {
                var currency = currensies[index];
                return ListTile(
                  leading: const Icon(Icons.money),
                  // Иконка для каждой валюты
                  title: Text(
                    currency.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(currency.key),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/coin", arguments: currency);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1, color: Colors.grey);
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Мой баланс',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Курсы валют',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'Заявки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История операций',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Выйти',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue, // Цвет активной кнопки
        onTap: _onItemTapped,
      ),
    );
  }
}
