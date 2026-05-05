import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';

class OrderCardDetail extends StatelessWidget {
  final OrderModel itemOrder;
  const OrderCardDetail({super.key, required this.itemOrder});

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
          Text(
            itemOrder.product.namaProduk ?? '',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            itemOrder.product.typeProduk ?? '',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
          SpaceHeight(8),
          Row(
            // Karena dua item, jadi rata kanan kiri
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${itemOrder.product.hargaProduk!.currencyFormatRp} x ${itemOrder.quantity}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(
                (itemOrder.product.hargaProduk! * itemOrder.quantity)
                    .currencyFormatRp,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800), 
              ),
            ],
          ),
        ],
      ),
    );
  }
}
