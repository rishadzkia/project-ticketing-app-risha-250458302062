import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_app/core/core.dart';
import 'package:ticketing_app/data/datasource/product_local_datasource.dart';
import 'package:ticketing_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';
import 'package:ticketing_app/presentation/home/pages/payment_success_page.dart';

class PaymentCashDialog extends StatefulWidget {
  final int totalPrice;
  const PaymentCashDialog({super.key, required this.totalPrice});

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  final nominalController = TextEditingController();
  // -1 = Ngga ada yang dipilih
  int paidIndex = -1;

  @override
  void initState() {
    nominalController.text = widget.totalPrice.currencyFormatRp;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpaceHeight(12),
          CustomTextField(
            controller: nominalController,
            label: "Masukkan Nominal",
          ),
          SpaceHeight(12),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () => setState(() {
                    paidIndex = 0;
                    nominalController.text = widget.totalPrice.currencyFormatRp;
                  }),
                  label: "Uang Pas",
                  borderRadius: 10,
                  fontSize: 14,
                  textColor: paidIndex == 0 ? AppColors.white : AppColors.grey,
                  color: paidIndex == 0
                      ? AppColors.primary
                      : Colors.transparent,
                ),
              ),
              SpaceWidth(12),
              Flexible(
                child: Button.filled(
                  onPressed: () => setState(() {
                    paidIndex = 1;
                    nominalController.text = 200000.currencyFormatRp;
                  }),
                  label: 200000.currencyFormatRp,
                  borderRadius: 10,
                  fontSize: 14,
                  textColor: paidIndex == 1 ? AppColors.white : AppColors.grey,
                  color: paidIndex == 1
                      ? AppColors.primary
                      : Colors.transparent,
                ),
              ),
            ],
          ),
          SpaceHeight(20),
          // Row(
          //   children: [
          //     Flexible(
          //       child: Button.filled(
          //         onPressed: () => setState(() => paidIndex = 2),
          //         label: 1000000.currencyFormatRp,
          //         borderRadius: 10,
          //         fontSize: 14,
          //         textColor: paidIndex == 2 ? AppColors.white : AppColors.grey,
          //         color: paidIndex == 2
          //             ? AppColors.primary
          //             : Colors.transparent,
          //       ),
          //     ),
          //     SpaceWidth(12),
          //     Flexible(
          //       child: Button.filled(
          //         onPressed: () => setState(() => paidIndex = 3),
          //         label: 50000.currencyFormatRp,
          //         borderRadius: 10,
          //         fontSize: 14,
          //         textColor: paidIndex == 3 ? AppColors.white : AppColors.grey,
          //         color: paidIndex == 3
          //             ? AppColors.primary
          //             : Colors.transparent,
          //       ),
          //     ),
          //   ],
          // ),
          SpaceHeight(24),
          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              state.maybeWhen(
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                orElse: () {},
                success:
                    (
                      orders,
                      totalQuantity,
                      totalPrice,
                      paymentNominal,
                      paymentMethod,
                      cashierId, 
                      cashierName,
                    ) { 
                      final orderModel = OrderModel(
                        paymentMethod: paymentMethod,
                        nominalPayment: paymentNominal,
                        orders: orders,
                        totalQuantity: totalQuantity,
                        totalPrice: totalPrice,
                        cashierId: cashierId,
                        cashierName: cashierName,
                        isSync: false,
                        transactionTime: DateTime.now().toIso8601String(),
                      );
                      ProductLocalDatasource.instance.insertOrder(orderModel);
                      context.pushReplacement(PaymentSuccessPage());
                    },
              );
              // TODO: implement listener
            },
            child: Button.filled(
              onPressed: () {},
              label: "Bayar",
              // paidindex -- 1 = Gak ada button yang dipilih
              disabled: paidIndex == -1,
              fontSize: 16,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
