import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';

import 'package:ticketing_app/core/extensions/extensions.dart';

import 'package:ticketing_app/presentation/home/model/order_model.dart';

class HistoryCard extends StatelessWidget {
  // Nama custom kalo mau manggil data dummy
  final OrderModel itemHistory;
  const HistoryCard({super.key, required this.itemHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Assets.icons.plus.svg(),
          SpaceWidth(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Panggil data dummy
                'tiket ${itemHistory.id.toString()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SpaceHeight(5),
              Text(
                DateFormat('dd MMM yyy').format(
                  DateTime(
                    int.parse(itemHistory.transactionTime.substring(0, 4)),
                    int.parse(itemHistory.transactionTime.substring(5, 7)),
                    int.parse(itemHistory.transactionTime.substring(8, 10)),
                  ), 
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          // Biar ruang di dalam widget flexible, untuk menghabiskan ruang di antara nama produk dan harga
          Spacer(),
          Text(
            // currency format = Dari template untuk menampilkan format harga sesuai dengan settingan yang ada di template
            itemHistory.totalPrice.currencyFormatRp,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
