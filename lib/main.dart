import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/presentation/auth/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
} 

class MainApp extends StatelessWidget { 
  const MainApp({super.key});
 
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
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
    ); 
  }
}
