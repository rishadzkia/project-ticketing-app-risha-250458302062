import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticketing_app/data/datasource/product_local_datasource.dart';
import 'package:ticketing_app/data/datasource/product_remote_datasource.dart';
import 'package:ticketing_app/data/model/request/create_ticket_request_model.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  final ProductLocalDatasource productLocalDatasource;
  ProductBloc(this.productRemoteDatasource, this.productLocalDatasource)
    : super(_Initial()) {
    List<Product> products = [];

    // emit = Manggil state
    on<_GetProducts>((event, emit) async {
      emit(_Loading());
      final response = await productRemoteDatasource.getProducts();
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data.data ?? [])),
      );
      // TODO: implement event handler
    });

    on<_SyncProducts>((event, emit) async {
      final List<ConnectivityResult> connectivityResult = await (Connectivity()
          .checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(_Error('Gak ada internet'));
      } else {
        emit(_Loading());
        final response = await productRemoteDatasource.getProducts();
        productLocalDatasource.removeAllProduct();
        productLocalDatasource.insertAllProducts(
          response.getOrElse(() => ProductResponseModel(data: [])).data ?? [],
        );

        products =
            response.getOrElse(() => ProductResponseModel(data: [])).data ?? [];
        emit(_Success(products));
      }
    });

    on<_GetProductsLocal>((event, emit) async {
      emit(_Loading());
      final localProducts = await productLocalDatasource.getAllProducts();
      products = localProducts;
      emit(_Success(products));
    });

    // Create ticket
    on<_CreateTicket>((event, emit) async {
      emit(_Loading());
      final requestData = CreateTicketRequestModel(
        name: event.model.name,
        price: event.model.price,
        stock: event.model.stock,
        categoryId: event.model.categoryId,
        criteria: event.model.criteria!.toLowerCase(),
      );
      final response = await productRemoteDatasource.createTicket(requestData);

      response.fold((error) => emit(_Error(error)), (data) {
        products.add(data.data);
        emit(_Success(products));
      });
    });

    on<_UpdateTicket>((event, emit) async {
      emit(_Loading());
      final requestData = CreateTicketRequestModel(
        name: event.model.name,
        price: event.model.price,
      );
      final response = await productRemoteDatasource.updateTicket(
        requestData,
        event.model.id!,
      );
      response.fold((error) => emit(_Error(error)), (success) {
        final updateProduct = products.map((products) {
          if (products.id == event.model.id) {
            return success.data;
          }
          return success.data;
        }).toList();
        products = updateProduct;
        emit(_Success(products));
      });
    });

    on<_DeleteTicket>((event, emit) async {
      emit(_Loading());
      final response = await productRemoteDatasource.deleteTicket(event.id);
      response.fold((error) => emit(_Error(error)), (success) {
        products.removeWhere((products) => products.id == event.id);
        emit(_Success(products));
      });
    });
  }
}
