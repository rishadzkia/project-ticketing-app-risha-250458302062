import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/assets/assets.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/components/custom_text_field.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:ticketing_app/presentation/home/pages/main_page.dart';

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
                        // Bloc Listener: Buat dengerin perubahan dari bloc,
                        // klo ada perubahan state dia bakal ngejalanin fungsi yang kita masukkin ke listener
                        // Biasanya dipakai untuk aksi sekali jalan dan tidak.
                        // Handling perubahan UI
                        // Kayak pindah halaman, tampilan snackbar, dialog, simpan token ke penyimpanan lokal, dll.
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: (data) async {
                                await AuthLocalDatasource().saveAuthData(data);
                                context.pushReplacement(MainPage());
                              },
                              error: (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
                          },
                          // Bloc Builder: Buat membangun UI berdasarkan state dari bloc
                          // Jadi kalau state berubah, dia bakal bangun ulang tampilan
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                        LoginEvent.login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    },
                                    label: "Login",
                                  );
                                },
                                loading: () =>
                                    Center(child: CircularProgressIndicator()),
                              );
                            },
                          ),
                        ),
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
