// sqflite => local database
// shared_preferences => Local storage

// sqflite itu database yang digunakan untuk penyimpanan data yang lebih kompleks
// di penyimpanan aplikasi mobila

// Cuma nyimpen tipe data sederhana aja, kayak string, int, double, bool list, map

// Prosesnya:
// Data awal: Objek => Map<String, dynamic>
// Data tersimpan
// Ambil data dari sqflite: Map<String, dynamic> -> Objek

import 'package:sqflite/sqflite.dart';
import 'package:ticketing_app/data/model/request/order_request_model.dart';
import 'package:ticketing_app/data/model/response/category_response_model.dart';
import 'package:ticketing_app/data/model/response/product_response_model.dart';
import 'package:ticketing_app/presentation/home/model/order_model.dart';

// Buat akses data di locl, bikin database, ambil data dari database lokal sqflite
class ProductLocalDatasource {
  // Ini dilakukan biar orang yang mau akses product local datasource itu gak bikin objek berkali kali

  // Atau gampangnya, kita bikin satu kantor pusat, fia langusng akses kantor pusat itu
  // Jadi kalau butuh data, langsung dateng aja ke kantor pusat, gausah bikin kantor pusat sendiri sendiri

  // Ini namanya singleton pattern => Objek utama yang bakaln dipakai di seluruh aplikasi
  // Jadi kalau mau akses data lokal, langsung akses ke instance ini, gausah bikin objek baru lagi

  // Jadi tinggal panggil ini aja
  ProductLocalDatasource._int();

  static final ProductLocalDatasource instance = ProductLocalDatasource._int();

  final String tableProduct = 'products';
  final String tableOrder = 'orders';
  final String tableOrderItem = 'order_items';
  final String tableCategories = 'category';

  // Kalau database nya ngga ada, buat database baru, kalau udah ada, langsung akses database yang udah ada
  // _database itu buat nyimpen objek database, karena pas awal buka aplikasi semisal kita gak yakin database nya ada,
  // maka kita bikin objek database baru
  // Jadi untuk jaga jaga dan meminimalisir error
  static Database? _database;

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $tableProduct (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  productId INTEGER,
  category_id INTEGER,
  name TEXT NOT NULL,
  description TEXT,
  price TEXT,
  image TEXT NULL,
  stock INTEGER,
  created_at TEXT,
  updated_at TEXT,
  criteria TEXT
  )
''');

    await db.execute('''
CREATE TABLE $tableCategories(
id INTEGER PRIMARY KEY AUTOINCREMENT,
categoryId INTEGER,
name TEXT NOT NULL,
description TEXT, 
image TEXT,
created_at TEXT,
updated_at TEXT
) 
''');

    await db.execute('''
CREATE TABLE $tableOrder (
id INTEGER PRIMARY KEY AUTO INCREMENT,
nominal INTEGER,
payment_method TEXT,
payment_amount INTEGER,
total_price INTEGER,
total_item INTEGER,
cashier_id INTEGER,
cashier_name TEXT,
transaction_time TEXT,
is_sync INTEGER DEFAULT 0
)
''');

    await db.execute('''
CREATE TABLE $tableOrderItem (
id INTEGER PRIMARY KEY AUTO INCREMENT,
id_order INTEGER,
id_product INTEGER,
quantity INTEGER,
price INTEGER
)
''');
  }

  // Inisisalisasi Database
  // Buat cari lokasi penyimpanan database lali membuka atau membuat database
  Future<Database> _initDb() async {
    // getdataabsepath dipakai buat ambil lokasi folder database di hp
    final path = await getDatabasesPath();
    // Ini variable buat lokasi penyimpanan database
    // Jadi nanti database kita disimpan dengan nama ticketing.db di lokasi yang udah ditentuin
    //sama getdatabasepath tadi
    final databasepath = '$path/ticketing.db';

    // openDatabase dipakai buat membuka database
    // Kalau database belum ada, sqflite bakal bikin baru, version 1 artinya versi database
    // onCreate dipakai kalau database baru dibuat, maka jalankan fungsi _createDB buat bikin tabel di database
    return openDatabase(databasepath, version: 1, onCreate: _createDB);
  }

  // Ambil database
  // Ini getter untuk ambil database, jadi nanti kalau butuh database,
  // tinggal panggil instance.database
  Future<Database> get database async {
    // Kalau database sudah ada, langsung pakai database yang ada
    // Ada ! karena kita udh yakin kalau database nya ada, soalnya kan udah di cek
    if (_database != null) return _database!;
    // Kalau ternyata database nya maish null, maka buat atau buka dulu database nya lewat _initDb
    _database = await _initDb();
    // Setelah dibuat atau dibuka, tinggal dikembalikan aja pakai return
    return _database!;
  }

  // Input semua data produk ke database
  // Ini buat simpen data produk ke database dalam bentuk list produk dari API
  Future<void> insertAllProducts(List<Product> products) async {
    // Mengambil database dulu
    final db = await instance.database;
    // Data di loop satu per satu
    for (var product in products) {
      // Masukkin data pake keyword insert

      await db.insert(
        // Karena buat produk, jadi masukkinnya ke table product
        tableProduct,

        // toLocalMap iitu artinya ubah produk dari API yang bentuknya objek, diubah jadi jadi map<String, dynamic>
        //biar bisa masuk ke database
        // Kenapa? karena sqflite itu nyimpennya dalam bentuk map,
        product.toLocalMap(),
        // Kalau data yang diinput nanti ternyata ada konflik, maka data lama bakal diganti dengan data baru
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Hapus semua data prdduk dari database
  Future<void> removeAllProduct() async {
    // Akses atau ambil database
    final db = await instance.database;
    // Langusng hapus semua data di tabel product soalnya ngga pake where
    await db.delete(tableProduct);
  }

  // Get data produk
  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    // rawQuery itu cuman uat menulis sql query manual
    // Query nya buat ambl data dari tabel produk dan kategori sekaligus
    // p = produk, c = kategori,
    // p* artinya ambil semua data dari tabel produk,

    //c.id as category_id itu artinya ambil id dari tabel kategori terus kasih nama alias category_id,
    //biar nanti pas di maping ke objek produk bisa tau itu id kategori, bukan id produk,
    //karena kan di tabel produk juga ada id

    // Ini namanya left join, penggabungan dari produk dan kategori
    // ON itu untuk mencocokan data produk dengan data kategori berdasarkan category_id

    // Karena pakeai left join, semua data produk tetap diambil, data category yang ngga ada di produk bakal null
    final List<Map<String, dynamic>> maps = await db.rawQuery(''' 
SELECT p.*, c.id as category_id, c.name as category_name, 
c.description as category_description, c.image as category_image, 
c.created_at as category_created_at, c.updated_at as category_updated_at
FROM $tableProduct p
LEFT JOIN $tableCategories c ON p.category_id = c.id
''');

    // Ini dipakai untuk membuat List<product> dari data map hasil query
    return List.generate(maps.length, (index) {
      // Ambil data produk hasil query (bentuknya Map<String, dynamic>) s

      final productMap = maps[index];
      // Buat bikin Map khusus kategori
      // Jadi kan hasil query itu gabungan produk dan kategori
      // Jadi nanti data category nya dipisahkan dulu ke categoryMap, baru nanti diubah jadi objek category

      final categoryMap = {
        'id': productMap['category_id'],
        'name': productMap['category_name'],
        'description': productMap['category_description'],
        'image': productMap['category_image'],
        'created_at': productMap['category_created_at'],
        'updated_at': productMap['category_updated_at'],
      };
      return Product.fromLocalMap(
        // Ubah data map menjadi objek produk
        productMap,
      )
      // Membuat salinan produk, tapi category nya diisi dengan objek
      .copyWith(
        category: Category.fromMap(categoryMap),
      ); // Mengubah map kategori jadi objek kategori
      // Hasil akhirnya produk udah punya kategori
    });
  }

  // Buat nyimpen data order ke database lokal, hasilnya nanti bakal mengembalikan id order yang baru dibuat
  Future<int> insertOrder(OrderModel order) async {
    final db = await instance.database;
    // Mengubah data objek order jadi map
    int id = await db.insert(
      tableOrder,
      order.toMapForLocal(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // loop semua item yang ada di order
    // Misal di 1 transaksi ada bbrp produk, maka setiap produk bakal disimpan ke table order item
    for (var orderItem in order.orders) {
      // Simpan ke tabel order item
      // DIubah dulu jadi map
      // id order dikrim supaya order item tau dia punya nya id order yang mana
      // id order utama itu disimpan sebagai id order di tabel oredr items
      await db.insert(
        tableOrderItem,
        orderItem.toMapForLocal(id),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return id;
  }

  // Ini fungsi buat ambil data order
  Future<List<OrderModel>> getAllOrder() async {
    final db = await instance.database;

    // Ambil data dari tabel order, diambil dari yang id nya paling besar
    // Jadi data paling baru, ada di atas
    final result = await db.query('orders', orderBy: 'id DESC');
    // Ubah data dari map jadi list
    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  // Ambil data order kalau gagal sync ke server
  // Dipakai pas aplikasi offline, jadi kalau app nya udh online, maka yang belum di sync data nya,
  //bakal dikirim ulang ke server
  Future<List<OrderModel>> getOrderIsSyncFalse() async {
    final db = await instance.database;
    // Ambil data dari tabel order
    // Yang diambil cuman data order yang belum di sync
    // 0 = belum di sync,
    //1 = udh di sync
    final result = await db.query('orders', where: 'is_sync = 0');
    // Ubah hasil query dari map jadi list
    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  // Update data order
  // Ini utnuk ubah status oredr yang tadinya belum sync, jadi sudah sync
  // Atau dari 0 jadi 1
  // Nanti diambilnya pake id
  Future<void> updateOrderIsSync(int id) async {
    final db = await instance.database;
    // Update data dengan id tertentu, is sync nya diubah jadi 1,
    // Artinya data udah di sync di server
    await db.update('orders', {'is_sync': 1}, 
    // Where buat menentukan data mana yang di update
    // id = ? artinya cari order 
    where: 'id = ?', whereArgs: [id]);
  }

  // Get order item berdasarkan id order
  // Kayak misal id order 5 itu punya 2 produk, nah function ini tuh buat ambil data 2 produk itu
  Future<List<OrderItemModel>> getOrderItemsByIdOrder(int idOrder) async {
    final db = await instance.database;
    // Ambil data dari tabel order item berdasarkan i order nya
    final result = await db.query('order_items', where: 'id_order = $idOrder');
    // Ubah data dari map jadi list
    return result.map((e) => OrderItemModel.fromMap(e)).toList();
  }

  // Buat nyimpen semua data kategori
  Future<void> insertAllCategory(List<Category> categories) async {
    final db = await instance.database;
    for (var category in categories) {
      // loop semu data kategori dari API, lalu di insert ke dalam tabel kategori,
      // dan diubah dari objek jadi map  
      await db.insert(
        tableCategories,
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } 
  }

  Future<void> removeAllCategory() async {
    final db = await instance.database;
    await db.delete(tableCategories);
  }
}
