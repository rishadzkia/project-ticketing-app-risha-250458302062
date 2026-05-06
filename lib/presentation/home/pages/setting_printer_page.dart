import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/model/printer_model.dart';
import 'package:ticketing_app/presentation/home/widget/menu_printer_button.dart';
import 'package:ticketing_app/presentation/home/widget/menu_printer_content.dart';

class SettingPrinterPage extends StatefulWidget {
  const SettingPrinterPage({super.key});

  @override
  State<SettingPrinterPage> createState() => _SettingPrinterPageState();
}

class _SettingPrinterPageState extends State<SettingPrinterPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Printer'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Container(
            width: context.deviceWidth / 2,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.stroke,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuPrinterButton(
                  label: 'Search',
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  isActive: selectedIndex == 0,
                ),
                MenuPrinterButton(
                  label: 'Disconnect',
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  isActive: selectedIndex == 1,
                ),
                MenuPrinterButton(
                  label: 'Test',
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  isActive: selectedIndex == 2,
                ),
              ],
            ),
          ),
          SpaceHeight(34),
          // Setting data 
          _Body(
            selectedIndex: selectedIndex,
            // Isi object dari printer model
            dataPrinter: printerWoe,
          ),
        ],
      ),
    );
  }
}

// Setiap widget harus ada build context
// INI PRIVATE

class _Body extends StatelessWidget {
  final int selectedIndex;
  final List<PrinterModel> dataPrinter;

  const _Body({required this.selectedIndex, required this.dataPrinter});

  @override
  Widget build(BuildContext context) {
    if (dataPrinter.isEmpty) {
      return Text('Tidak ada printer yang ditemukan');
    } else if (selectedIndex == 0) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => MenuPrinterContent(
            data: dataPrinter[index],
            // selected index dr parameter yang td dibuat
            isSelected: selectedIndex == index,
          ),
          separatorBuilder: (context, index) => SpaceHeight(12),
          // Buat ngeluarin data nya, pake length
          itemCount: dataPrinter.length,
        ),
      );
    } else if (selectedIndex == 1) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => MenuPrinterContent(
            data: dataPrinter[index],
            // selected index dr parameter yang td dibuat
            isSelected: selectedIndex == index,
          ),
          separatorBuilder: (context, index) => SpaceHeight(12),
          itemCount: dataPrinter.length,
        ),
      );
    } else if (selectedIndex == 2) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => MenuPrinterContent(
            data: dataPrinter[index],
            // selected index dr parameter yang td dibuat
            isSelected: selectedIndex == index,
          ),
          separatorBuilder: (context, index) => SpaceHeight(12),
          itemCount: dataPrinter.length,
        ),
      );
    }
    return Placeholder();
  }
}
