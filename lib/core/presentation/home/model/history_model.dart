class HistoryModel {
  final String name;
  final int price;
  final DateTime dateTime;

  HistoryModel({
    required this.name,
    required this.price,
    required this.dateTime,
  });
}

// Ini object
List<HistoryModel> histories = [
  HistoryModel(
    name: 'Bus A',
    price: 50000,
    dateTime: DateTime(2024, 6, 1, 10, 0),
  ),
  HistoryModel(
    name: 'Waterpark',
    price: 25000,
    dateTime: DateTime(2024, 6, 1, 10, 0),
  ),
  HistoryModel(
    name: 'Zoo',
    price: 15000,
    dateTime: DateTime(2024, 6, 1, 10, 0),
  ),
];
