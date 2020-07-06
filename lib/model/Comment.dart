import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String get uid => _uid;
  String _uid;

  String content;
  double rate;
  String buyerUid;
  DocumentReference referance;

  Comment({
    this.content,
    this.rate,
    this.buyerUid,
  });

  Comment.fromMap(Map<String, dynamic> map, {this.referance, uid})
      : assert(map['content'] != null),
        content = map['content'],
        assert(map['rate'] != null),
        rate = map['rate'].toDouble(),
        assert(map['buyerUid'] != null),
        buyerUid = map['buyerUid'],
        _uid = uid;

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, referance: snapshot.reference, uid: snapshot.documentID);

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'rate': rate,
      'buyerUid': buyerUid,
    };
  }
}
