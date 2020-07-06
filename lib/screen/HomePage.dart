import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgeneral/data/dealer_service.dart';
import 'package:orgeneral/data/product_service.dart';
import 'package:orgeneral/screen/ProductPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: HomeGridView(),
    );
  }
}

class HomeGridView extends StatefulWidget {
  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

BuildContext _context;

class _HomeGridViewState extends State<HomeGridView> {
  List<Map<String, dynamic>> dapList = List(); // dap -> Dealer And Product

  @override
  void initState() {
    super.initState();
    asyncInitState();
  } //initState

  Future<void> asyncInitState() async {
    await DealerService.getAllDealers().then((_dealers) {
      dapList.clear();
      // setState(() {
      _dealers.forEach((_dealer) async {
        String _dealerUid = _dealer.referance.documentID;
        await ProductService.getInDealer(dealerUid: _dealerUid).then((_products) async {
          _products.forEach((_product) {
            setState(() {
              dapList.add({'dealer': _dealer, 'product': _product});
            });
            print('product: ${_product.name}');
          }); //product
        }); //products
      }); //dealer
      // }); //setState
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return GridView.count(
      padding: EdgeInsets.all(4.0),
      crossAxisCount: 2,
      childAspectRatio: (8 / 9),
      children: List.generate(dapList.length, (index) => gridItem(dapList[index])),
    );
  }
}

Widget gridItem(Map<String, dynamic> dap) {
  if (dap != null && dap.isNotEmpty) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.blue,
      ),
      height: 250.0,
      margin: EdgeInsets.all(8.0),
      child: RawMaterialButton(
        onPressed: () {
          print('uid: ${dap['product'].uid}');
          Navigator.push(
              _context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  dealerUid: dap['dealer'].uid,
                  productUid: dap['product'].uid,
                ),
              ));
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: dap['product'].imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  height: 130,
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(dap['product'].name),
                          Text('adet ${dap['product'].price}₺'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(dap['dealer'].name),
                          Row(
                            children: <Widget>[
                              Text('5'),
                              Icon(Icons.star, size: 20, color: Colors.yellow[800]),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    return Text('Hata');
  }
}
