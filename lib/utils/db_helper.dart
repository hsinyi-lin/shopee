import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;
  static final DBHelper instance = DBHelper._();

  DBHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  
  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'shopping.db');

    // print('Database path: $dbPath');

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Products(
        id INTEGER PRIMARY KEY,
        storeName TEXT,
        image TEXT,
        productName TEXT,
        price INTEGER,
        soldCnt INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Cart(
        id INTEGER PRIMARY KEY,
        storeName TEXT,
        image TEXT,
        productName TEXT,
        price INTEGER,
        soldCnt INTEGER,
        quantity INTEGER
      )
    ''');

    final List<Map<String, dynamic>> products = [
      {
        'id': 1,
        'storeName': '中衛醫療口罩商家',
        'image': 'assets/images/product1.jpg',
        'productName': '【公司貨】可刷卡💯CSD 中衛醫療口罩 成人 兒童 平面口罩《第一等級》中衛口罩',
        'price': 79,
        'soldCnt': 340,
      },
      {
        'id': 2,
        'storeName': 'KingCamp商家',
        'image': 'assets/images/product2.jpg',
        'productName': 'KingCamp羽絨衝鋒衣男三合一冬季可拆卸加厚防水防風登山服外套女',
        'price': 1677,
        'soldCnt': 3,
      },
      {
        'id': 3,
        'storeName': '五月花商家',
        'image': 'assets/images/product3.jpg',
        'productName': 'RJ購 🙏一筆超取訂單限1組2串🙏【五月花】舒 敏厚棒 抽取式衛生紙60抽 (1組售價=2串共12包)',
        'price': 159,
        'soldCnt': 340,
      },
      {
        'id': 4,
        'storeName': '松露黑巧克力商家',
        'image': 'assets/images/product4.jpg',
        'productName': '🍉新北出貨🚚【熱賣低價】原材料松露黑巧克力代可可脂大桶裝網紅兒童零食',
        'price': 139,
        'soldCnt': 3,
      },
      {
        'id': 5,
        'storeName': '舒潔商家',
        'image': 'assets/images/product5.jpg',
        'productName': '宅配免運Kleenex 舒潔】香氛舒適白茶沁香抽取式衛生紙 100抽x8包x2串',
        'price': 499,
        'soldCnt': 340,
      },
      {
        'id': 6,
        'storeName': '金莎巧克力商家',
        'image': 'assets/images/product6.jpg',
        'productName': '❤️限時特價❤️金莎巧克力 情人節禮物 生日禮物',
        'price': 25,
        'soldCnt': 3,
      },
    ];

    for (var product in products) {
      await db.insert('Products', product);
    }
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('Products');
  }
  

  Future<void> addToCart(Map<String, dynamic> product) async {
    final db = await database;
    final existingProduct = await db.query(
      'Cart',
      where: 'productName = ?',
      whereArgs: [product['productName']],
    );

    if (existingProduct.isNotEmpty) {
      final currentQuantity = existingProduct[0]['quantity'] as int? ?? 0;
      await db.update(
        'Cart',
        {'quantity': currentQuantity + 1},
        where: 'productName = ?',
        whereArgs: [product['productName']],
      );
    } else {
      await db.insert('Cart', {
        'storeName': product['storeName'],
        'image': product['image'],
        'productName': product['productName'],
        'price': product['price'],
        'soldCnt': product['soldCnt'],
        'quantity': 1,
      });
    }
  }

  Future<void> updateCartItemQuantity(String productName, int quantity) async {
    final db = await database;
    await db.update(
      'Cart',
      {'quantity': quantity},
      where: 'productName = ?',
      whereArgs: [productName],
    );
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return await db.query('Cart');
  }
}
