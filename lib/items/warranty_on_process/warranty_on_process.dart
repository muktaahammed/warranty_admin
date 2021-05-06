import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/on_warranty_process.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class OnWarrantyProcessList extends StatefulWidget {
  OnWarrantyProcessList({Key key}) : super(key: key);

  @override
  _ItemunderWarrantyListState createState() => _ItemunderWarrantyListState();
}

class _ItemunderWarrantyListState extends State<OnWarrantyProcessList> {
  List<OnWarrantyProcess> _info = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item On Warranty Process'),
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
          future: AuthService.onWarrantyProcess(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['on_warranty_list'];

              for (var i = 0; i < data.length; i++) {
                _info.add(OnWarrantyProcess.fromJson(data[i]));
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
          _info[index].status,
          _info[index].code,
          _info[index].total,
          _info[index].onWarrantyList,

          //_info[index].onWarrantyList[0],
        );
      },
    );
  }

  Card _tile(
    var status,
    var code,
    var total,
    var onWarrantyList,
  ) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                child: Column(
                  children: [
                    Text(status.toString() ?? null),
                    Text(onWarrantyList.toString() ?? null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
