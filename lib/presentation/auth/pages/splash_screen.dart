import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/presentation/auth/pages/login.dart';
import 'package:ticketing_app/presentation/home/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // FutureBuilder itu widget yang bisa ngebangun tampilan berdasarkan hasil dari sebuah future.
        // Jadi dia bakalan nunggu future selesai, terus dia bakal bngun tampilan sesuai dgn hasilnya.
        future: Future.delayed(
          Duration(seconds: 3),
          () => AuthLocalDatasource().isLogin(),
        ),
        // snapshot itu hasil dr future
        // Atau laporan hasil dr pengecekan apakah user sudah login atau belum
        // Jadi bisa diisi hasil apakah prosesnya masih loading atau sudah selesai
        // datanya seperti apa atau error nya sprti apa
        builder: (context, snapshot) {
          // snapshot.connectionState itu buat cek status future
          if (snapshot.connectionState == ConnectionState.done) {
            // snapshot.data itu hasil dr future, isinya true atau false 
            // Hasil terakhitya true or false
            if (snapshot.data == true) {
              return MainPage();
            } else {
              return LoginPage();
            }
          }
          return Stack(
            children: [
              Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(80),
                    child: Center(
                      child: Assets.images.logoBlue.image(height: 200),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Ticketing App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  SpaceHeight(40),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
