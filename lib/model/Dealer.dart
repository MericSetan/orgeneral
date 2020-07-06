import 'package:cloud_firestore/cloud_firestore.dart';

class Dealer {
  String get uid => _uid;
  String _uid;

  String name;
  String imageUrl;
  DocumentReference referance;

  Dealer({
    this.name,
    this.imageUrl,
  });

  Dealer.empty()
      : this.name = '',
        this.imageUrl = '',
        this._uid = '';

  Dealer.fromMap(Map<String, dynamic> map, {this.referance, uid})
      : assert(map['name'] != null),
        name = map['name'],
        assert(map['imageUrl'] != null),
        imageUrl = map['imageUrl'],
        _uid = uid;

  Dealer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, referance: snapshot.reference, uid: snapshot.documentID);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
