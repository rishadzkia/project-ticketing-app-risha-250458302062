import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/presentation/home/dialog/add_ticket_dialog.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';
import 'package:ticketing_app/presentation/home/widget/ticket_widget.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Tiket'),
        // Pake action karena button tambah nya ada di sebelah kanan 
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddTicketDialog(),
              );
            },
            icon: Assets.icons.plus.svg(),
          ),
          SpaceWidth(8),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) =>
            TicketCardWidget(itemProduk: produks[index]),
        separatorBuilder: (context, index) => SpaceHeight(20),
        itemCount: produks.length,
      ),
    );
  }
}
