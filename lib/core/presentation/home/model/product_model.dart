class ProductModel {
  // Final harus udh ditentukan isinya
  final String namaProduk;
  final String typeProduk;
  final int hargaProduk;
  int quantity;

  ProductModel({
    required this.namaProduk,
    required this.typeProduk,
    required this.hargaProduk,
    this.quantity = 1,
  });
}

final produks = [
  ProductModel(
    namaProduk: 'Bus A',
    typeProduk: 'Transportasi',
    hargaProduk: 50000,
  ),
  ProductModel(
    namaProduk: 'Waterpark',
    typeProduk: 'Rekreasi',
    hargaProduk: 25000,
  ),
  ProductModel(
  namaProduk: 'Zoo', 
  typeProduk: 'Rekreasi', 
  hargaProduk: 15000
  ),
];
