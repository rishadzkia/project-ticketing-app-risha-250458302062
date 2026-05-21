import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_app/data/datasource/order_remote_datasource.dart';
import 'package:ticketing_app/data/datasource/product_local_datasource.dart';
import 'package:ticketing_app/data/model/request/order_request_model.dart';

part 'sync_order_event.dart';
part 'sync_order_state.dart';
part 'sync_order_bloc.freezed.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDataSource orderRemoteDataSource;
  SyncOrderBloc(this.orderRemoteDataSource) : super(_Initial()) {
    on<_SyncOrder>((event, emit) async {
      emit(_Loading());
      try {
        final orderIsSyncFalse = await
        ProductLocalDatasource.instance.getOrderIsSyncFalse();
        bool hasError = false;
        for (final order in orderIsSyncFalse) {
          try {
            print('Syncing order ID : ${order.id}');
            final orderItems = await
            ProductLocalDatasource.instance.getOrderItemsByIdOrder(order.id!);

            print('Order items found : ${orderItems.length}');

            final orderRequest = OrderRequestModel(
              cashierName: order.cashierName,
              paymentAmount: order.nominalPayment,
              transactionTime: order.transactionTime,
              cashierId: order.cashierId,
              totalPrice: order.totalPrice,
              totalItem: order.totalQuantity,
              paymentMethod: order.paymentMethod,
              orderItems: orderItems
            );
          }
        }

      }
      // TODO: implement event handler
    });
  }
}
