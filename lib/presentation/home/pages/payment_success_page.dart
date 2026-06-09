import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';
import 'package:ticketing_app/presentation/home/pages/main_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  final OrderModel order;
  const PaymentSuccessPage({super.key, required this.order});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Payment Receipt',
          style: TextStyle(color: AppColors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            context.pushReplacement(MainPage());
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Assets.images.back.image(color: AppColors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // Ini biar color nya setengah setengah
            height: context.deviceHeight / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              color: AppColors.primary,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // Karena mau naruh konten di image
              image: DecorationImage(
                image: Assets.images.receiptCard.provider(),
                alignment: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(60),
              child: Column(
                children: [
                  Text(
                    'PAYMENT RECEIPT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SpaceHeight(16),
                  QrImageView(
                    data:
                        '${widget.order.cashierId}#${widget.order.transactionTime}',
                    version: QrVersions.auto,
                  ),
                  SpaceHeight(16),
                  Text('Scan this QR Code to verify tickets'),
                  SpaceHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tagihan',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(widget.order.totalPrice.currencyFormatRp),
                    ],
                  ),
                  SpaceHeight(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Metode Bayar',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(widget.order.paymentMethod),
                    ],
                  ),
                  SpaceHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(DateTime.now().toFormattedDate()),
                    ],
                  ),
                  SpaceHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text('Success'),
                    ],
                  ),
                  SpaceHeight(8),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(36, 0, 36, 20),
        child: Button.filled(
          onPressed: () async {
            
          },
          label: 'Cetak Transaksi',
          borderRadius: 10,
        ),
      ),
    );
  }
}
