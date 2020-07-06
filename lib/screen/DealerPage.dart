import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgeneral/data/product_service.dart';
import 'package:orgeneral/model/Dealer.dart';
import 'package:orgeneral/widget/ProductsGridView.dart';

class DealerPage extends StatefulWidget {
  final Dealer dealer;

  DealerPage({
    @required this.dealer,
  });

  @override
  _DealerPageState createState() => _DealerPageState();
}

BuildContext _context;

class _DealerPageState extends State<DealerPage> {
  List<Map<String, dynamic>> dapList = List<Map<String, dynamic>>();

  @override
  void initState() {
    super.initState();
    dapList.clear();
    asyncInitState();
  }

  Future<void> asyncInitState() async {
    await ProductService.getInDealer(dealerUid: widget.dealer.uid).then((_products) {
      _products.forEach((_product) {
        setState(() {
          dapList.add({'dealer': widget.dealer, 'product': _product});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: buildListView(),
    );
  }

  Widget buildListView() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          buildDealerImage(),
          buildDealerDetails(),
          buildDealerProducts(dapList),
        ],
      ),
    );
  }

  Widget buildDealerImage() {
    return Container(
      height: MediaQuery.of(_context).size.width,
      child: CachedNetworkImage(
        imageUrl: widget.dealer.imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget buildDealerDetails() {
    return Column(
      children: <Widget>[
        Text(widget.dealer.name),
      ],
    );
  }

  Widget buildDealerProducts(List<Map<String, dynamic>> dapList) {
    return ProductsGridView(dapList);
  }
}
