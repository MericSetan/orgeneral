import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orgeneral/model/Dealer.dart';

class DealerService {
  static DealerService _singleton = DealerService._internal();

  factory DealerService() {
    return _singleton;
  }

  DealerService._internal();

  static final _db = Firestore.instance;

  static Future<List<Dealer>> getAllDealers() async {
    var _dealers;
    await _db.collection('dealers').getDocuments().then((value) {
      _dealers = List<Dealer>();
      value.documents.forEach((snapshot) {
        _dealers.add(Dealer.fromSnapshot(snapshot));
      });
    });
    return _dealers;
  }

  static Future<bool> add(Dealer dealer) async {
    bool _isCompleted = false;
    await _db.collection('dealers').add(dealer.toMap()).whenComplete(() => _isCompleted = true);
    return _isCompleted;
  }
}
