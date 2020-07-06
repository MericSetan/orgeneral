import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String get uid => _uid;
  String _uid;

  String name;
  String imageUrl;
  double price;
  DocumentReference referance;

  Product({
    this.name,
    this.imageUrl,
    this.price,
  });

  Product.empty()
      : this.name = '',
        this.imageUrl = '',
        this.price = 0;

  Product.fromMap(Map<String, dynamic> map, {this.referance, uid})
      : assert(map['name'] != null),
        name = map['name'],
        assert(map['imageUrl'] != null),
        imageUrl = map['imageUrl'],
        assert(map['price'] != null),
        price = map['price'].toDouble(),
        _uid = uid;

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, referance: snapshot.reference, uid: snapshot.documentID);

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': imageUrl, 'price': price};
  }
}
