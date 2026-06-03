import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:ticketing_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:ticketing_app/presentation/home/dialog/add_ticket_dialog.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';
import 'package:ticketing_app/presentation/home/widget/ticket_widget.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductEvent.getProducts());
    super.initState();
  }

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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          List<Product> products = state.maybeWhen(
            orElse: () => [], 
            success: (products) => products,
          );
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemBuilder: (context, index) =>
                TicketCardWidget(itemProduk: products[index]), 
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemCount: produks.length,
          );
        },
      ),
    );
  }
}
