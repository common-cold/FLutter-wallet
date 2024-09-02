import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/generate_wallet.dart';
import 'screens/balance.dart';
import 'screens/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/generateWallet': (context) => GenerateWallet(),
      '/balance': (context) => Balance(),
    },
  ));
}

