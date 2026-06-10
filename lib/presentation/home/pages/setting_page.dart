import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/data/datasource/product_local_datasource.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:ticketing_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:ticketing_app/presentation/auth/pages/login.dart'; 
import 'package:ticketing_app/presentation/home/bloc/category/category_bloc.dart';
import 'package:ticketing_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:ticketing_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:ticketing_app/presentation/home/bloc/sync_order/sync_order_bloc.dart';
import 'package:ticketing_app/presentation/home/dialog/logout_dialog.dart';
import 'package:ticketing_app/presentation/home/dialog/sync_dialog.dart';
import 'package:ticketing_app/presentation/home/pages/setting_printer_page.dart';
import 'package:ticketing_app/presentation/home/widget/setting_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: GridView.count(
        // Bikin 2 kolom nya
        crossAxisCount: 2,
        padding: EdgeInsets.all(24),
        crossAxisSpacing: 15,
        mainAxisSpacing: 24,
        children: [
          SettingButton(
            iconPath: Assets.icons.settings.printer.path,
            title: 'Printer',
            subtitle: 'Kelola Printer',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => SettingPrinterPage()),
              );
            },
          ),
          BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              // Ini buat biar kita ngga nulis kondisi di semua state
              // di bagian ini kita cuman mau milih state success aja, kalau error atau loading kita ngga ngapa ngapain
              state.maybeWhen(
                success: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  // Handle logout success
                },
                orElse: () {},
              );
              // TODO: implement listener
            },
            child: SettingButton(
              iconPath: Assets.icons.settings.logout.path,
              title: 'Logout',
              subtitle: 'Keluar dari Akun',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => LogoutDialog(),
                );
              },
            ),
          ),
          BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                success: (categories) {
                  ProductLocalDatasource.instance.removeAllCategory();
                  ProductLocalDatasource.instance.insertAllCategory(categories);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sync category berhasil"),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              );
              // TODO: implement listener
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
                orElse: () {
                  return SettingButton(
                    iconPath: Assets.icons.settings.syncData.path,
                    title: 'Sync Category',
                    subtitle: 'Sinkronkan Data Kategori',
                    onPressed: () {
                      context.read<CategoryBloc>().add(CategoryEvent.fetch());
                    },
                  );
                },
              );
            },
          ),
          // Sync Product
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                success: (products) {
                  ProductLocalDatasource.instance.removeAllProduct();
                  ProductLocalDatasource.instance.insertAllProducts(products);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sync product berhasil"),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              );
              // TODO: implement listener
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
                orElse: () {
                  return SettingButton(
                    iconPath: Assets.icons.settings.syncData.path,
                    title: 'Sync Product',
                    subtitle: 'Sinkronkan Data Produk',
                    onPressed: () {
                      context.read<ProductBloc>().add(
                        ProductEvent.getProducts(),
                      );
                    },
                  );
                },
              );
            },
          ),

          // Sync Order
          BlocConsumer<SyncOrderBloc, SyncOrderState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                success: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sync data order berhasil"),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              );
              // TODO: implement listener
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
                orElse: () {
                  return SettingButton(
                    iconPath: Assets.icons.settings.syncData.path,
                    title: 'Sync Order',
                    subtitle: 'Sinkronkan Data Order',
                    onPressed: () {
                      context.read<SyncOrderBloc>().add(
                        SyncOrderEvent.syncOrder(),
                      );
                    },
                  );
                },
              );
            },
          ),

          SettingButton(
            iconPath: Assets.icons.settings.printer.path,
            title: 'Profile',
            subtitle: 'Kelola Profil',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
