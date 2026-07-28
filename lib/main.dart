import 'package:flutter/material.dart';
import 'package:vstore/data/repo/banner_repository.dart';
import 'package:vstore/data/repo/product_repository.dart';
import 'package:vstore/theme.dart';
import 'package:vstore/ui/home/home.dart';
import 'package:vstore/ui/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    productRepository
        .getProducts(0)
        .then((value) {
          debugPrint(value.toString());
        })
        .catchError((e) {
          debugPrint(e.toString());
        });

    bannerRepository
        .getBanners()
        .then((value) {
          debugPrint(value.toString());
        })
        .catchError((e) {
          debugPrint(e.toString());
        });
    return MaterialApp(
      title: 'Vision Store',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode
          .system, // will switch automatically later — swap to a Bloc-driven value once you wire up your theme cubit/bloc
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: RootScreen(),
      ),
    );
  }
}
