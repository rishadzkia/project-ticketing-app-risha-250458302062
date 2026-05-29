import 'package:flutter/material.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/dialog/payment_cash_dialog.dart';
import 'package:ticketing_app/presentation/home/dialog/payment_qris_dialog.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';
import 'package:ticketing_app/presentation/home/widget/order_card_detail.dart';
import 'package:ticketing_app/presentation/home/widget/payment_method.dart';

class OrderDetailPage extends StatelessWidget {
  final List<ProductModel> dataProduks;
  const OrderDetailPage({super.key, required this.dataProduks});

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
      // body:
      // ListView.separated(
      //   itemBuilder: (context, index) =>
      //       OrderCardDetail(item: dataProduks[index]),
      //   separatorBuilder: (context, index) => SpaceHeight(20),
      //   itemCount: dataProduks.length,
      // ),
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
                        Text(
                          60000.currencyFormatRp,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
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
                          showDialog(
                            context: context,
                            builder: (context) =>
                                // Harus diikutin sama yang required
                                PaymentCashDialog(totalPrice: 14000),
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
