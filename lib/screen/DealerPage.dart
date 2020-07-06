import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgeneral/model/Dealer.dart';

class DealerPage extends StatefulWidget {
  final Dealer dealer;

  DealerPage({
    @required this.dealer,
  });

  @override
  _DealerPageState createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: Text('dealerUid: ${widget.dealer.uid}'),
    );
  }
}
