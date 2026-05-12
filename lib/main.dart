import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/data/datasource/auth_remote_datasource.dart';
import 'package:ticketing_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:ticketing_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:ticketing_app/presentation/auth/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [ 
        // Ini isinya bloc bloc yang udh dibikin 
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ticketing App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.outfit(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: AppColors.black),
            centerTitle: true,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
