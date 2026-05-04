import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/presentation/home/model/printer_model.dart';

class MenuPrinterContent extends StatelessWidget {
  final PrinterModel data;
  final bool isSelected;
  const MenuPrinterContent({
    super.key,
    required this.data,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Printer: ${data.name}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            'Alamat MAC: ${data.address}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
