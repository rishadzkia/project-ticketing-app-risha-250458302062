import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';
import 'package:ticketing_app/core/extensions/extensions.dart';
import 'package:ticketing_app/data/datasource/auth_local_datasource.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';

class TransactionPrint {
  TransactionPrint._init();

  static final TransactionPrint instance = TransactionPrint._init();

  Future<List<int>> printTransaction(OrderModel order) async {
    List<int> bytes = [];

    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final namaKasir = authData.user?.name ?? 'Tidaks Ada';
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      // Header
      bytes += generator.text('==========', 
      styles: PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.text('TIKET WISATA APPLAND',
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
        bold: true,
      ), containsChinese: true);
      bytes += generator.text('==========', 
      styles: PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.feed(1);

      // Detail
      bytes += generator.row([
        PosColumn(
          text: 'No Transaksi: ', width: 6
        ),
        PosColumn(
          text: order.id != null ? 'TRX-${order.id}' : 'TRX-NEW',
          width: 6,
          styles: PosStyles(
            align: PosAlign.right
          )
        )
      ]);

      bytes += generator.row([
        PosColumn(
          text: 'Tanggal: ', width: 6
        ),
        PosColumn(
          text: DateFormat('dd-MM-yyy HH:mm:ss').format(DateTime.now()),
          
          width: 6,
          
        ) 
      ]);

      bytes += generator.row([ 
        PosColumn(
          text: 'Nama Kasir: ', width: 6
        ),
        PosColumn(
          text: namaKasir,
          width: 6,
          
        )
      ]);

      bytes += generator.feed(1);

      // Detail item
      for(var item in order.orders) {
        bytes += generator.row([
          PosColumn(
            text: item.product.name ?? '',
            width: 8,
            styles: PosStyles(
              align: PosAlign.left
            )
          ),
          PosColumn(
            text: 'x${item.quantity}',
            width: 4,
            styles: PosStyles(
              align: PosAlign.right
            )
          )
        ]);

        // Detail Harga
        bytes += generator.row([
          PosColumn(
            text: '', width: 6
          ),
          PosColumn(
            text: item.product.price!.currencyFormatRp,
            width: 6,
            styles: PosStyles(
              align: PosAlign.right
            )
          )
        ]);
      }

      bytes += generator.text(
        '----------',
        styles: PosStyles(
          align: PosAlign.center, bold: true
        )
      );

      // Total Harga
      bytes += generator.row([
          PosColumn(
            text: 'Total', width: 6, styles: PosStyles(bold: true)
          ),
          PosColumn(
            text: order.totalPrice.currencyFormatRp,
            width: 6,
            styles: PosStyles(
              align: PosAlign.right
            )
          )
        ]);
    } 

   
  }
}