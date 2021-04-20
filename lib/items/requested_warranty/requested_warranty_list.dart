import 'package:flutter/material.dart';
import 'package:warranty_admin/items/requested_warranty/requested_deatils.dart';
import 'package:warranty_admin/models/data_model/requested_item_details.dart';
import 'package:warranty_admin/items/requested_warranty/update_status.dart';
import '../../provider/auth_service.dart';

class ViewRequestedList extends StatefulWidget {
  ViewRequestedList({Key key}) : super(key: key);

  @override
  _ViewRequestedListState createState() => _ViewRequestedListState();
}

class _ViewRequestedListState extends State<ViewRequestedList> {
  List<RequestedItemDetails> _info = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requested For Warranty List'),
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
          future: AuthService.viewRequestedItems(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['requested_product_list'];

              for (var i = 0; i < data.length; i++) {
                _info.add(RequestedItemDetails.fromJson(data[i]));
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

  Widget _widgetBody(context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _info.length,
        itemBuilder: (context, index) {
          return _tile(
            _info[index].id,
            _info[index].email,
            _info[index].phone,
            _info[index].name,
            _info[index].dob,
            _info[index].buyerId,
            _info[index].gender,
            _info[index].joinDate,
            _info[index].photo,
            _info[index].orderId,
            _info[index].stage0,
            _info[index].stage1,
            _info[index].stage2,
            _info[index].stage3,
            _info[index].stage4,
            _info[index].stage5,
          );
        });
  }

  Card _tile(
    int id,
    String email,
    String phone,
    String name,
    String dob,
    String buyerId,
    String gender,
    String joinDate,
    String photo,
    String orderId,
    String stage0,
    String stage1,
    String stage2,
    String stage3,
    String stage4,
    String stage5,
  ) {
    RequestedItemDetails info = RequestedItemDetails(
        id,
        email,
        phone,
        name,
        dob,
        buyerId,
        gender,
        joinDate,
        photo,
        orderId,
        stage0,
        stage1,
        stage2,
        stage3,
        stage4,
        stage5);

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
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    print('Trailing preesed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RequestedDetails(requestedDetails: info),
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    color: Colors.grey[200],
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        'Update Status',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateStatus(orderId: info),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    /* return Card(
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
                            RequestedDetails(requestedDetails: info),
                      ),
                    );
                  }),
            ),
             Container(
              width: MediaQuery.of(context).size.width,
              //margin: const EdgeInsets.only( bottom: 10.0),
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Update Status',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateStatus(orderId: info),
                      ));
                },
              ),
            ), 
          ],
        ),
      ),
    ); */
  }
}
