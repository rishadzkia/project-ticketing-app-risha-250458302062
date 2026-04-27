import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/components/custom_text_field.dart';
import 'package:ticketing_app/core/constants/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.primary,
      // Mau ada penumpukan background dan form login (Menimpa)
      body: Stack(
        children: [ 
          SizedBox(
            height: 260,
            child: Center(child: Assets.images.logoBlue.image(height: 200)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // Biar keyboard  ya menyesuaikan dengan ukuran layar
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 44),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          label: "Email Address",
                        ),
                        SpaceHeight(36),
                        CustomTextField(
                          controller: passwordController,
                          label: "Password",
                          obscureText: true,
                        ),
                        SpaceHeight(84),
                        Button.filled(onPressed: () {}, label: "Login"),
                        SpaceHeight(16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
