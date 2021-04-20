import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/view_equipment.dart';
import 'package:warranty_admin/provider/auth_service.dart';
import 'package:warranty_admin/items/added_equipment/view_equipment_details.dart';

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
            //_info[index].id,
            _info[index].brandName,
            _info[index].serialNumber,
            _info[index].modelNumber,
            _info[index].modelName,
            _info[index].productType,
            _info[index].warrantyPeriod,
            _info[index].partsName,
            _info[index].partsWarranty,
            _info[index].parts2Name,
            _info[index].parts2Length,
          );
        });
  }

  Card _tile(
    //int id,
    String brandName,
    String serialNumber,
    String modelNumber,
    String modelName,
    String productType,
    int warrantyPeriod,
    String partsName,
    String partsWarranty,
    String parts2Name,
    String parts2Length,
  ) {
    ViewEquipments info = ViewEquipments(
      // id,
      brandName,
      serialNumber,
      modelNumber,
      modelName,
      productType,
      warrantyPeriod,
      partsName,
      partsWarranty,
      parts2Name,
      parts2Length,
    );
    return Card(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  // Visitor's name
                  brandName,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              trailing: IconButton(
                //View more details button
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  print('Trailing preesed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewEquipmentsDetails(equipDetails: info),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
