part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.getProducts() = _GetProducts;
  // sinkronisasi data dari localhost ke local hp
  const factory ProductEvent.syncProducts() = _SyncProducts;
  // Ini ngambil data dari hp
  const factory ProductEvent.getLocalProducts() = _GetProductsLocal;

  // Add Ticket
  const factory ProductEvent.createTicket(Product model) = _CreateTicket;
  const factory ProductEvent.updateTicket(Product model) = _UpdateTicket;
  const factory ProductEvent.deleteTicket(int id) = _DeleteTicket;
}
