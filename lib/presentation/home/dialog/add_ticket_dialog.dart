import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/core.dart';

class AddTicketDialog extends StatelessWidget {
  const AddTicketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Pake final biar isi nya gak berubah
    final criteria = ['single', 'group'];
    final category = ['berenang', 'zoo', 'museum'];

    final nameController = TextEditingController();
    final priceController = TextEditingController();
    // Value notifer itu tempat untuk menaruh sesuatu yang baklan berubah 
    // Perubahannya direkam sama valuelistenablebuilder
    final categoryNotifier = ValueNotifier(category.first);
    final criteriaNotifier = ValueNotifier(criteria.first);

  // Ini tempat untuk nyimpan replace-an
    int parseCurrency(String text) =>
    // Ini untuk replcae biar ngga ada string 
        int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    priceController.text = parseCurrency(priceController.text).currencyFormatRp;
    return AlertDialog(
      // Biar ngasih space untuk keyboard 
      content: SingleChildScrollView(
        child: Column(
          children: [
            SpaceHeight(8),
            CustomTextField(controller: nameController, label: 'Nama Tiket'),
            SpaceHeight(8),
            CustomTextField(
              controller: priceController,
              label: 'Harga Tiket',
              // Keyboard nya bentuknya angka
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsedValue = parseCurrency(value).currencyFormatRp;
                priceController.value = TextEditingValue(
                  text: parsedValue,
                  selection: TextSelection.collapsed(
                    offset: parsedValue.length,
                  ),
                );
              },
            ),
            SpaceHeight(8),
            ValueListenableBuilder(
              // pertama yang direkam adalah category
              valueListenable: categoryNotifier,
              // _ = widget, widget nya itu customdropdown
              builder: (context, value, _) => CustomDropdown(
                // value ini isinya data yang ada di database, jadi namanya disesuaikan sama nama yang ada di database
                value: value,
                items: category,
                label: 'Kategori Tiket',
                onChanged: (value) => categoryNotifier.value = value!,
              ),
            ),
            SpaceHeight(8),
            ValueListenableBuilder(
              valueListenable: criteriaNotifier,
              // builder pasti diisi context
              builder: (context, value, _) => CustomDropdown(
                // value: yang kesimpen di database
                value: value,
                // item = yang muncul di tampilan
                items: criteria,
                label: 'Kriteria Tiket',
                onChanged: (value) => criteriaNotifier.value = value!,
              ),
            ),
            SpaceHeight(40),
            Row(
              children: [
                Flexible(
                  child: Button.filled(
                    onPressed: () => context.pop(),
                    label: 'Batalkan',
                    borderRadius: 12,
                    color: AppColors.buttonCancel,
                    textColor: AppColors.grey,
                  ),
                ),
                SpaceWidth(12),
                Flexible(
                  child: Button.filled(
                    onPressed: () => context.pop(),
                    label: 'Simpan',
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
