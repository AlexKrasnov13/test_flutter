import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedBottomAppBar extends StatefulWidget {
  const RoundedBottomAppBar({super.key});

  @override
  State<RoundedBottomAppBar> createState() => _RoundedBottomAppBarState();
}

class _RoundedBottomAppBarState extends State<RoundedBottomAppBar> {
  var _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 44, // Устанавливаем высоту нижней навигационной панели
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50), // Радиус скругления углов
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // Всегда отображать названия вместе с иконками
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
              icon: Icon(
                Icons.request_page,
                size: 20,
              ),
              activeIcon: Icon(Icons.icecream),
              label: 'Создать',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Операций',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Выйти',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue,
          iconSize: 18,
          // Размер иконок
          selectedFontSize: 10,
          // Уменьшаем высоту текста активного элемента
          unselectedFontSize: 10,
          // Уменьшаем высоту текста неактивных элементов
          // Цвет активной кнопки
          onTap: _onItemTapped,
        ));
  }
}
