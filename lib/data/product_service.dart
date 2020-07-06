import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orgeneral/model/Product.dart';

class ProductService {
  static ProductService _singleton = ProductService._internal();

  factory ProductService() {
    return _singleton;
  }

  ProductService._internal();

  static final _db = Firestore.instance;

  static Future<List<Product>> getAllProducts() async {
    List<Product> _products;
    await _db.collection('dealers').getDocuments().then((value) {
      value.documents.forEach((snapshot) {
        snapshot.reference.collection('products').getDocuments().then((value) {
          _products = List.generate(
              value.documents.length, (index) => Product.fromSnapshot(value.documents[index]));
        });
      });
    });
    return _products;
  }

  static Future<List<Product>> getInDealer({String dealerUid}) async {
    List<Product> _products;
    await _db
        .collection('dealers')
        .document(dealerUid)
        .collection('products')
        .getDocuments()
        .then((value) {
      _products = List.generate(
          value.documents.length, (index) => Product.fromSnapshot(value.documents[index]));
    });
    return _products;
  }

  static Future<Product> getWithUid(String dealerUid, String productUid) async {
    var _product;
    await _db
        .collection('dealers')
        .document(dealerUid)
        .collection('products')
        .document(productUid)
        .get()
        .then((snapshot) => _product = Product.fromSnapshot(snapshot));
    return _product;
  }

  static Future<bool> add(String dealerUid, Product product) async {
    bool _isCompleted = false;

    var productRef = _db.collection('dealers').document(dealerUid);

    await productRef
        .collection('products')
        .add(product.toMap())
        .whenComplete(() => _isCompleted = true);

    return _isCompleted;
  }
}
