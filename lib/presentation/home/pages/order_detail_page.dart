import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:ticketing_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:ticketing_app/presentation/home/dialog/payment_cash_dialog.dart';
import 'package:ticketing_app/presentation/home/dialog/payment_qris_dialog.dart';
import 'package:ticketing_app/presentation/home/model/order_item_model.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';
import 'package:ticketing_app/presentation/home/widget/order_card_detail.dart';
import 'package:ticketing_app/presentation/home/widget/payment_method.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int totalPrice = 0;
  List<OrderItem> orderItems = [];
  @override
  Widget build(BuildContext context) {
    int paymentButtonIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Assets.images.back.image(),
          ),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            orElse: () => [],
            success: (checkout) => checkout,
          );
          return ListView.separated(
            itemBuilder: (context, index) =>
                OrderCardDetail(item: products[index]),
            separatorBuilder: (context, index) => SpaceHeight(20),
            itemCount: products.length,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Karena setiap button nya ada action nya masing masing yang berneda
            StatefulBuilder(
              builder: (context, setState) => Row(
                children: [
                  Expanded(
                    child: PaymentMethodButton(
                      iconPath: Assets.icons.payment.qris.path,
                      label: "QRIS",
                      isActive: paymentButtonIndex == 0,
                      onPressed: () => setState(() => paymentButtonIndex = 0),
                    ),
                  ),
                  SpaceWidth(20),
                  Expanded(
                    child: PaymentMethodButton(
                      iconPath: Assets.icons.payment.qris.path,
                      label: "QRIS",
                      isActive: paymentButtonIndex == 0,
                      onPressed: () => setState(() => paymentButtonIndex = 0),
                    ),
                  ),
                  SpaceWidth(20),
                  Expanded(
                    child: PaymentMethodButton(
                      iconPath: Assets.icons.payment.qris.path,
                      label: "Tunai",
                      isActive: paymentButtonIndex == 1,
                      onPressed: () => setState(() => paymentButtonIndex = 1),
                    ),
                  ),
                  SpaceWidth(20),
                  Expanded(
                    child: PaymentMethodButton(
                      iconPath: Assets.icons.payment.qris.path,
                      label: "Transfer",
                      isActive: paymentButtonIndex == 2,
                      onPressed: () => setState(() => paymentButtonIndex = 2),
                    ),
                  ),
                ],
              ),
            ),
            SpaceHeight(24),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 0,
                    offset: Offset(0, -2),
                    color: AppColors.black.withOpacity(0.8),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Order Summary',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              success: (checkout) {
                                orderItems = checkout;
                                final total = checkout.fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue +
                                      element.product.price! * element.quantity,
                                );
                                totalPrice = total;
                                return Text(
                                  total.currencyFormatRp,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                );
                              },
                              orElse: () => Text(
                                '0',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Mengambil space
                  Expanded(
                    // Mau ngambil satu space, jadi biar langusng kebagi 2
                    flex: 1,
                    child: Button.filled(
                      onPressed: () {
                        if (paymentButtonIndex == 0) { 
                          showDialog(
                            context: context,
                            builder: (context) => PaymentQrisDialog(),
                          );
                        } else if (paymentButtonIndex == 1) {
                          context.read<OrderBloc>().add(
                            OrderEvent.addPaymentMethod('Tunai', orderItems),
                          );
                          showDialog(
                            context: context,
                            builder: (context) =>
                                // Harus diikutin sama yang required
                                PaymentCashDialog(totalPrice: totalPrice),
                          );
                        }
                      },
                      label: "Process",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
