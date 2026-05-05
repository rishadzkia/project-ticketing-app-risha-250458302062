// Class, Property, Constructor, Object

class PrinterModel {
  final String name;
  final int address;

  PrinterModel({required this.name, required this.address});
}

// Ini alternatif bentuk selain pake List
final printerWoe = [
  PrinterModel(name: 'Printer A', address: 12345),
  PrinterModel(name: 'Printer B', address: 67890),
  PrinterModel(name: 'Printer C', address: 11111),
];

