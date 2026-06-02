import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/components/components.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/extensions.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:ticketing_app/presentation/home/model/product_model.dart';

class OrderCard extends StatelessWidget { 
  final Product itemProduk;
  const OrderCard({super.key, required this.itemProduk}); 

  @override
  Widget build(BuildContext context) { 
    final quantityNotifier = ValueNotifier(0);
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
                  itemProduk.name ?? 'Tidak ada nama produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                // Saat di tap mau ada action apa
                onTap: () {
                  if (quantityNotifier.value > 0) {
                    quantityNotifier.value--;
                  }
                },
                child: Assets.icons.reduceQuantity.svg(),
              ),
              // Mengubah UI jika ada sesutu yang berubah
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                // Builder formatnya ada tiga
                builder: (context, value, _) => Text(
                  '$value',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),

              // Ini button untuk tambah quantity
              InkWell(
                onTap: () => quantityNotifier.value++,
                child: Assets.icons.addQuantity.svg(),
              ),
            ],
          ),
          Text(
            // itemProduk: Nyimpen data model
            // Biasanya kalo dia punya class tersendiri, dikasih tanda tanya
            itemProduk.category?.name ?? 'Tidak ada kategori',
            style: TextStyle( 
              fontSize: 12,
              fontWeight: FontWeight.w400, 
              color: AppColors.grey, 
            ),
          ),
          SpaceHeight(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // Kasih negasi karena currency format Rp itu butuh data yang pasti,
                //jadi kasih tanda tanya untuk ngasih tau kalo dia bisa null
                itemProduk.price!.currencyFormatRp,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              // Pake ini karena diawal pake valuenotifier
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                builder: (context, value, child) => Text(
                  (itemProduk.price! * value).currencyFormatRp,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
