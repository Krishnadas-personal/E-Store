import 'dart:io';

import 'package:e_store/provider/category_provider.dart';
import 'package:e_store/screens/products_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/products_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const typeTheme = Typography.whiteMountainView;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'E-store',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: const Color(0xFF222431),
          textTheme: Typography.whiteMountainView.copyWith(
            bodyLarge: MyApp.typeTheme.bodyText1?.copyWith(
                color: const Color.fromRGBO(20, 51, 51, 1), fontSize: 24),
            bodyMedium: MyApp.typeTheme.bodyText1?.copyWith(
              color: const Color.fromRGBO(20, 51, 51, 1),
              fontSize: 20,
            ),
            titleSmall: MyApp.typeTheme.bodyText1?.copyWith(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'RobotoCondensed'),
            titleMedium: MyApp.typeTheme.bodyText1?.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'RobotoCondensed'),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          ProductScreen.routeName: (cxt) => const ProductScreen(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
