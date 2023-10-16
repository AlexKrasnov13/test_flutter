import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:test_flutter/exceptions/result.dart';
import 'package:test_flutter/repository/auth_repository.dart';
import 'package:test_flutter/theme/customTheme.dart';

var logger = Logger();

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  // Поля для ввода имени пользователя и пароля
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    String username = _usernameController.text;
    if (username.isEmpty) {
      _errorMessage = 'Не указано имя пользователя';
    }
    String password = _passwordController.text;
    if (password.isEmpty) {
      _errorMessage = 'Пароль не указан';
    }
    var authenticate =
        await GetIt.I<AuthRepository>().authenticate(username, password);

    final token = switch (authenticate) {
      Success() => {if (context.mounted) Navigator.pushNamed(context, '/menu')},
      Failure(exception: final exception) => {
          _errorMessage = exception.getMessage(),
          setState(() {
            _isLoading = false;
          })
        },
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        centerTitle: true,
          automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo/md_logo.png", height: 150, width: 150),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.login),
                  labelText: 'Имя пользователя',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Не меньше 6 символов',
                  labelText: 'Пароль',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Войти'),
              ),
              if (_errorMessage.isNotEmpty) const SizedBox(height: 16.0),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
