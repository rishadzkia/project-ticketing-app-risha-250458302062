import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/presentation/home/dialog/logout_dialog.dart';
import 'package:ticketing_app/presentation/home/dialog/sync_dialog.dart';
import 'package:ticketing_app/presentation/home/widget/setting_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(24),
        crossAxisSpacing: 15,
        mainAxisSpacing: 24,
        children: [
          SettingButton(
            iconPath: Assets.icons.settings.printer.path,
            title: 'Printer',
            subtitle: 'Kelola Printer',
            onPressed: () {},
          ),
          SettingButton(
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
          SettingButton(
            iconPath: Assets.icons.settings.syncData.path,
            title: 'Sync Category',
            subtitle: 'Sinkronkan Data Kategori',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SyncDataDialog(),
              );
            },
          ),
          SettingButton(
            iconPath: Assets.icons.settings.syncData.path,
            title: 'Sync Produk',
            subtitle: 'Sinkronkan Data Produk',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SyncDataDialog(),
              );
            },
          ),
          SettingButton(
            iconPath: Assets.icons.settings.syncData.path,
            title: 'Sync Order',
            subtitle: 'Sinkronkan Data Order',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SyncDataDialog(),
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
