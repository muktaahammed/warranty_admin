import 'package:flutter/material.dart';
import 'package:warranty_admin/items/all_items/view_all_items_details.dart';
import 'package:warranty_admin/models/data_model/view_all_items.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class ViewAllItemsList extends StatefulWidget {
  ViewAllItemsList({Key key}) : super(key: key);

  @override
  _ViewAllItemsState createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItemsList> {

  List<ViewAllItemsModel> _info = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View All Items List'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.grey[200],
        child: FutureBuilder<Map<String, dynamic>>(
          future: AuthService.viewAllItems(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['items_array'];

              for (var i = 0; i < data.length; i++) {
                _info.add(ViewAllItemsModel.fromJson(data[i]));
              }
              //
              print(data.length);
              return _widgetBody(context);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 25.0,
                  width: 25.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _widgetBody(context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _info.length,
        itemBuilder: (context, index) {
          return _tile(
            _info[index].id,
            _info[index].buyerName,
            _info[index].buyerEmail,
            _info[index].buyerPhone,
            _info[index].buyerId,
            _info[index].orderId,
            _info[index].brandName,
            _info[index].brandModel,
            _info[index].warrantyLength,
            _info[index].startdate,
            _info[index].expireDate,
            _info[index].category,
            _info[index].parts1Name,
            _info[index].parts1Warranty,
            _info[index].parts2Name,
            _info[index].parts2Warranty,
          );
        });
  }

  Card _tile(
    var id,
    var buyerName,
    var buyerEmail,
    var buyerPhone,
    var buyerId,
    var orderId,
    var brandName,
    var brandModel,
    var warrantyLength,
    var startdate,
    var expireDate,
    var category,
    var parts1Name,
    var parts1Warranty,
    var parts2Name,
    var parts2Warranty,
  ) {
    ViewAllItemsModel info = ViewAllItemsModel(
      id,
      buyerName,
      buyerEmail,
      buyerPhone,
      buyerId,
      orderId,
      brandName,
      brandModel,
      warrantyLength,
      startdate,
      expireDate,
      category,
      parts1Name,
      parts1Warranty,
      parts2Name,
      parts2Warranty,
    );

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Container(
                child: Text(orderId),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    print('Trailing preesed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AllItemsDetails(allItemDetails: info),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
