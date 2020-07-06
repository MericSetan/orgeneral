import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orgeneral/model/Comment.dart';

class CommentService {
  static CommentService _singleton = CommentService._internal();

  factory CommentService() {
    return _singleton;
  }

  CommentService._internal();

  static final _db = Firestore.instance;

  static Future<List<Comment>> getInDealer({String dealerUid}) async {
    List<Comment> _comments;
    await _db
        .collection('dealers')
        .document(dealerUid)
        .collection('comments')
        .getDocuments()
        .then((value) {
      _comments = List.generate(
          value.documents.length, (index) => Comment.fromSnapshot(value.documents[index]));
    });
    return _comments;
  }

  static Future<List<Comment>> getInProduct({String dealerUid, String productUid}) async {
    List<Comment> _comments;
    await _db
        .collection('dealers')
        .document(dealerUid)
        .collection('products')
        .document(productUid)
        .collection('comments')
        .getDocuments()
        .then((value) {
      _comments = List.generate(
          value.documents.length, (index) => Comment.fromSnapshot(value.documents[index]));
    });
    return _comments;
  }

  // static Future<Comment> getWithUid(String dealerUid, String commentUid) async {
  //   var _comment;
  //   await _db
  //       .collection('dealers')
  //       .document(dealerUid)
  //       .collection('comments')
  //       .document(commentUid)
  //       .get()
  //       .then((snapshot) => _comment = Comment.fromSnapshot(snapshot));
  //   return _comment;
  // }

  // static Future<bool> add(String dealerUid, Comment comment) async {
  //   bool _isCompleted = false;

  //   var commentRef = _db.collection('dealers').document(dealerUid);

  //   await commentRef
  //       .collection('comments')
  //       .add(comment.toMap())
  //       .whenComplete(() => _isCompleted = true);

  //   return _isCompleted;
  // }
}
