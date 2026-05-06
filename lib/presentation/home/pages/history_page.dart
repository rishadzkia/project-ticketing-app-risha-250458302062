import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/presentation/home/model/history_model.dart';
import 'package:ticketing_app/presentation/home/widget/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pake mapping krn ada key dan value. Key: Mei 2026, value: List<HistoryModel> atau kumpulan history di bulan tsb.
    // Jadi, groupedHistory dipakai untuk mengelompokkan transaksi berdasarkan bulan dan tahun
    Map<String, List<HistoryModel>> groupedHistory = {};
    // for: looping
    // krn mau ngeluarin data untuk jadi history
    // histories: object dari history model
    // data: Nama perumpamaan
    for (var data in histories) {
      final monthYear =
          // Ubah format nya jadi bulan (Mei 2026)
          '${data.dateTime.toFormattedMonth()} ${data.dateTime.year}';
      // Ini utk ngecek apakah bulan dan tahun itu masih ada,
      // maka akan dibuat daftar kosong untuk menyimpan data transaksi di bulan tsb.
      if (!groupedHistory.containsKey(monthYear)) {
        groupedHistory[monthYear] = [];
      }
      // Ini buat masukkin transaksi ke kelompok bulan yang sesuai
      // add: method
      groupedHistory[monthYear]!.add(data);
    }
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: ListView(
        padding: EdgeInsets.all(16),
        // Ini untuk nge-looping data yang udh di kelompokin
        // groupeHistoryEntries: Untuk ngambil semua data key dan value dari map
        // Contoh isinya=
        // Mei 2026 = [Data 1, Data 2, Data 3]
        children: groupedHistory.entries.map((entry) {
          // Untuk ambil key dari map => Mei 2026
          final monthYear = entry.key;
          // Buat ambil data value
          // Bentuknya list transaksi
          final data = entry.value;

          // Ini buat ngitung total harga transaksi yang ada di bulan tsb.
          // Fold: Buat hitung total harga transaksi di bulan tsb.
          final total = data.fold(
            // Nol itu nilai awal
            // previousValue: Nilai sementara/Nilai terakhir/Data terakhir
            // element: Nilai dari satu data transaksi
            // element.price: Harga transaksi
            0,
            (previousValue, element) => previousValue + element.price,
          );
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      monthYear,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      total.currencyFormatRp,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Garis batasan
                Divider(
                  thickness: 3,
                  color: AppColors.primary,
                  endIndent: context.deviceWidth - 60,
                ),
                // ... itu spread operator
                // Artinya ini buat nambahin semua data transaksi di bulan tsb.
                // Jadi kita ngga pake itu, hasilnya cuman dianggap 1 list dalam list
                // Bukan kumpulan widget history
                // Data itu kan isinya List Transaski
                // Map fungsinya buat ngubah liat transaksi jadi history card
                // Pake to.list itu buat nambahin semua widget history card ke dalam list
                ...data.map((item) => HistoryCard(itemHistory: item)).toList(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
