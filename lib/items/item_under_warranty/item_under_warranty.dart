import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/item_under_warranty.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class ItemUnderWarranty extends StatefulWidget {
  ItemUnderWarranty({Key key}) : super(key: key);

  @override
  _ItemUnderWarrantyState createState() => _ItemUnderWarrantyState();
}

class _ItemUnderWarrantyState extends State<ItemUnderWarranty> {
  List<UnderWarrentyList> _info = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Under Warranty'),
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
          future: AuthService.totalUnderWarranty(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['warrenty_product_list'];

              for (var i = 0; i < data.length; i++) {
                _info.add(UnderWarrentyList.fromJson(data[i]));
              }
              //
              print(data.length);
              return _underWarrantyBody(context);
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

  _underWarrantyBody(context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _info.length,
        itemBuilder: (context, index) {
          return _tile(
            //_info[index].activeUser,
            _info[index].bname,
            _info[index].bemail,
            _info[index].bphone,
          );
        });
  }

  Card _tile(
    //var activeUsers,
    var bName,
    var bEmail,
    var bPhone,
  ) {
    UnderWarrentyList info = UnderWarrentyList(
      //activeUser: activeUsers,
      bname: bName,
      bemail: bEmail,
      bphone: bPhone,
    );

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bName),
                    Text(bEmail),
                    Text(bPhone),
                  ],
                ),
              ),

              /* trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  print('Trailing preesed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersDeatils(usersDeatils: info),
                    ),
                  );
                },
              ), */
            ),
          ],
        ),
      ),
    );
  }
}
