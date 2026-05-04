import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/extensions.dart';
import 'package:ticketing_app/core/presentation/home/dialog/delete_ticket_dialog.dart';
import 'package:ticketing_app/core/presentation/home/dialog/edit_ticket_dialog.dart';
import 'package:ticketing_app/core/presentation/home/model/product_model.dart';

class TicketCardWidget extends StatelessWidget {
  final ProductModel itemProduk;
  const TicketCardWidget({super.key, required this.itemProduk});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemProduk.namaProduk,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      itemProduk.typeProduk,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteTicketDialog(),
                  );
                },
                icon: Assets.icons.delete.svg(),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        EditTicketDialog(itemProduk: itemProduk),
                  );
                },
                icon: Assets.icons.edit.svg(),
              ),
            ],
          ),
          SpaceHeight(8),
          Text(
            itemProduk.hargaProduk.currencyFormatRp,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
