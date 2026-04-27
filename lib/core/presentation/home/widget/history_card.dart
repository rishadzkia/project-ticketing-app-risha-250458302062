import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/date_time_ext.dart';
import 'package:ticketing_app/core/extensions/extensions.dart';
import 'package:ticketing_app/core/presentation/home/model/history_model.dart';

class HistoryCard extends StatelessWidget {
  // Nama custom kalo mau manggil data dummy
  final HistoryModel itemHistory;
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
                itemHistory.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SpaceHeight(5),
              Text(
                itemHistory.dateTime.toFormattedDayTime(),
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
            itemHistory.price.currencyFormatRp,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
