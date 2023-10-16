import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/dto/Currency.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key,  required this.currentCurrency});

  final Currency currentCurrency;

  // @override
  // void initState() {
  //   super.initState();
  //   dio.interceptors.add(AuthInterceptor());
  //   fetchData();
  // }
  //
  // Future<void> fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     // Response response = await dio.get('/currency');
  //     // List<dynamic> responseData = response.data;
  //     // List<Currency> parsedData =
  //     //     responseData.map((data) => Currency.fromJson(data)).toList();
  //     setState(() {
  //       //currencies = parsedData;
  //       isLoading = false;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('Ошибка загрузки данных: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(currentCurrency.icon, size: 48.0),
              const SizedBox(height: 16.0),
              Text(
                currentCurrency.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                currentCurrency.key,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              //  SizedBox(height: 16.0),
              // Text(
              //   currentCurrency.description,
              //   style: TextStyle(fontSize: 16.0),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
