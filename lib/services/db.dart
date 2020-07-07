import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orgeneral/model/Dealer.dart';
import 'package:orgeneral/model/Product.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<Product> streamProduct(String dealerId, String productId) {
    return _db
        .collection('dealers')
        .document(dealerId)
        .collection('products')
        .document(productId)
        .snapshots()
        .map((snapshot) => Product.fromSnapshot(snapshot));
  }

  Stream<List<Product>> streamProducts(String dealerId) {
    var ref = _db.collection('dealers').document(dealerId).collection('products');
    return ref.snapshots().map((list) => 
        list.documents.map((snapshot) => Product.fromSnapshot(snapshot)).toList());
  }

  Stream<Dealer> streamDealer(String dealerId) {
    return _db
        .collection('dealers')
        .document(dealerId)
        .snapshots()
        .map((snapshot) => Dealer.fromSnapshot(snapshot));
  }

  Stream<List<Dealer>> streamDealers() {
    var ref = _db.collection('dealers');
    return ref.snapshots().map((list) => 
        list.documents.map((snapshot) => Dealer.fromSnapshot(snapshot)).toList());
  }
}
