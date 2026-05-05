import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/auth/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      // PushReplacement to Login Page: Itu menghapus halaman splsh
      () => context.pushReplacement(LoginPage()),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Assets.images.logoBlue.image()),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Ticketing App",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
