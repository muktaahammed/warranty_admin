import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/view_equipment.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class ViewAddedEquipment extends StatefulWidget {
  ViewAddedEquipment({Key key}) : super(key: key);

  @override
  _ViewAddedEquipmentState createState() => _ViewAddedEquipmentState();
}

class _ViewAddedEquipmentState extends State<ViewAddedEquipment> {
  List<ViewEquipments> _info = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added Equipment'),
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
        //authService.viewAddedEquipments(),
        child: FutureBuilder<Map<String, dynamic>>(
          future: AuthService.viewAddedEquipments(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['Equipments_array'];

              for (var i = 0; i < data.length; i++) {
                _info.add(ViewEquipments.fromJson(data[i]));
                // _info.add(ViewEquipments.fromJson(data[i]));
              }
              //
              print(data.length);
              return _widgetBody();
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

  Widget _widgetBody() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _info.length,
        itemBuilder: (context, index) {
          return _tile(
            _info[index].brandName,
            _info[index].serialNumber,
            _info[index].modelNumber,
            _info[index].modelName,
            _info[index].productType,
            _info[index].partsWarranty,
          );
        });
  }

  Card _tile(
    String brandName,
    String serialNumber,
    String modelNumber,
    String modelName,
    String productType,
    String partsWarranty,
  ) {
    return Card(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Brand Name : "),
                        Text(brandName),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Serial Number : "),
                        Text(serialNumber),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Model Number : "),
                        Text(modelNumber),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Brand Name : "),
                        Text(brandName),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Category : "),
                        Text(productType),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
