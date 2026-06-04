import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/extensions.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:ticketing_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:ticketing_app/presentation/home/model/order_item_model.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';

class OrderCard extends StatefulWidget {
  final Product itemProduk;
  const OrderCard({super.key, required this.itemProduk});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.itemProduk.name ?? 'Tidak ada nama produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                // Saat di tap mau ada action apa
                onTap: () {
                  context.read<CheckoutBloc>().add(
                    CheckoutEvent.removeCheckout(widget.itemProduk),
                  );
                },
                child: Assets.icons.reduceQuantity.svg(),
              ),
              // Mengubah UI jika ada sesutu yang berubah
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final quantity = state.maybeWhen(
                    success: (checkout) => checkout
                        .firstWhere(
                          (e) => e.product.id == widget.itemProduk.id,
                          orElse: () => OrderItem(
                            product: widget.itemProduk,
                            quantity: 0,
                          ),
                        )
                        .quantity,

                    orElse: () => 0,
                  );
                  return Text(
                    quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
              // Ini button untuk tambah quantity
              InkWell(
                onTap: () {
                  context.read<CheckoutBloc>().add(
                    CheckoutEvent.addCheckout(widget.itemProduk),
                  );
                },
                child: Assets.icons.addQuantity.svg(),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                // itemProduk: Nyimpen data model
                // Biasanya kalo dia punya class tersendiri, dikasih tanda tanya
                widget.itemProduk.category?.name ?? 'Tidak ada kategori',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          SpaceHeight(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // Kasih negasi karena currency format Rp itu butuh data yang pasti,
                //jadi kasih tanda tanya untuk ngasih tau kalo dia bisa null
                widget.itemProduk.price!.currencyFormatRp,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              // Pake ini karena diawal pake valuenotifier
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (checkout) {
                      final quantity = checkout
                          .firstWhere(
                            (e) => e.product.id == widget.itemProduk.id,
                            orElse: () => OrderItem(
                              product: widget.itemProduk,
                              quantity: 0,
                            ),
                          )
                          .quantity;
                      return Text(
                        (widget.itemProduk.price! * quantity).currencyFormatRp,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      );
                    },
                    orElse: () => Text(
                      '0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
