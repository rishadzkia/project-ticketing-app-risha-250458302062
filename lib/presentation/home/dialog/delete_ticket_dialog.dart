import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/build_context_ext.dart';

class DeleteTicketDialog extends StatelessWidget {
  const DeleteTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hapus Tiket',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SpaceHeight(12),
          Text(
            'Apakah anda yakin untuk menghapus tiket ini?',
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
                  onPressed: () => context.pop(),
                  label: 'Hapus',
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
