import 'package:flutter/material.dart';
import 'package:test_flutter/widget/mainMenu/nav.dart';

class User {
  final String avatarUrl;
  final String name;

  User({required this.avatarUrl, required this.name});
}

class CurrencyInfo {
  final IconData icon;
  final String balance;

  CurrencyInfo({required this.icon, required this.balance});
}

class ProfileWidget extends StatefulWidget {
  ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TextEditingController _search = TextEditingController();

  final user = User(
      avatarUrl:
          'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/avatar-icon.png',
      name: 'Имя Пользователя');
  final currencies = [
    CurrencyInfo(icon: Icons.currency_pound, balance: '100 USD'),
    CurrencyInfo(icon: Icons.currency_yuan, balance: '50 EUR'),
    CurrencyInfo(icon: Icons.currency_bitcoin, balance: '30 GBP'),
    CurrencyInfo(icon: Icons.currency_ruble, balance: '2000 JPY'),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 4) {
      // _showLogoutDialog();
    } else {
      // Добавьте здесь навигацию для других кнопок
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
            color: Colors.black, // Темный фон
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 30,
                  // Уменьшенная высота поля для поиска
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900, // Серый фон
                    borderRadius:
                        BorderRadius.circular(20), // Закругленные углы
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade300),
                      // Иконка поиска
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white, height: 1),
                          decoration: InputDecoration(
                            hintText: 'Поиск',
                            border: InputBorder.none, // Убираем линию внизу
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                        radius: 30, // Увеличенный размер аватара
                      ),
                      SizedBox(width: 16),
                      Text(
                        user.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20), // Чуть уменьшенный размер имени
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      var currency = currencies[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.grey[900], // Цвет карточки
                          child: ListTile(
                            leading: Icon(currency.icon, color: Colors.white),
                            title: Text(
                              currency.balance,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: RoundedBottomAppBar())
    );
  }
}
