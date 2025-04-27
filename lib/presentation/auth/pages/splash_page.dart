import 'package:ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Future.delayed(const Duration(milliseconds: 200),
            () => AuthLocalDatasource().checkLoginData()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return const MainPage();
              } else {
                return const LoginPage();
              }
            }
          }
          return Padding(
            padding: const EdgeInsets.all(130.0),
            child: Center(
              child: Assets.images.logo.image(),
            ),
          );
        },
      ),
    );
  }
}
