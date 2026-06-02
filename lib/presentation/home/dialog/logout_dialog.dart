import 'package:flutter/material.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/build_context_ext.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/presentation/auth/pages/login.dart';
import 'package:ticketing_app/presentation/auth/pages/splash_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Logout',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SpaceHeight(20),
          Text(
            'Apakah anda yakin untuk logout dari aplikasi?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          SpaceHeight(20),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () => context.pop(),
                  label: 'Batalkan',
                  borderRadius: 8,
                  color: AppColors.buttonCancel,
                  textColor: AppColors.grey,
                  height: 44,
                  fontSize: 14,
                ),
              ),
              SpaceWidth(12),
              Flexible(
                child: Button.filled(
                  onPressed: () async {
                    // pop = Untuk nutup dialog nya,
                    //karena kita udh yakin buat logout, jadi dialog nya ngga perlu lagi
                    context.pop();
                    await AuthLocalDatasource().removeAuthData();
                    context.pushReplacement(SplashScreen());
                  },
                  label: 'Logout',
                  borderRadius: 8,
                  height: 44,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
