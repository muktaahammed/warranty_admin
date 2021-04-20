import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/view_equipment.dart';

import '../../const/style.dart';

class ViewEquipmentsDetails extends StatefulWidget {
  final ViewEquipments equipDetails;

  ViewEquipmentsDetails({Key key, @required this.equipDetails})
      : super(key: key);

  @override
  _ViewEquipmentsDetailsState createState() =>
      _ViewEquipmentsDetailsState(equipDetails);
}

class _ViewEquipmentsDetailsState extends State<ViewEquipmentsDetails> {
  final ViewEquipments equipDetails;
  _ViewEquipmentsDetailsState(this.equipDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added Equipment Details'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Brand Name : ', style: normalStyle),
                Text(equipDetails.brandName, style: normalStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Serial Number : ', style: normalStyle),
                Text(equipDetails.serialNumber, style: normalStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Model Number : ', style: normalStyle),
                Text(equipDetails.modelNumber, style: normalStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Model Name : ',
                  style: normalStyle,
                ),
                Text(equipDetails.modelName ?? 'No information',
                    style: normalStyle),
              ],
            ),
            //
            //
            //
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Product Category : ',
                  style: normalStyle,
                ),
                Text(equipDetails.productType ?? 'No information',
                    style: normalStyle),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Warranty Length : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.warrantyPeriod.toString() + ' Days' ??
                      'No information',
                  style: normalStyle,
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Parts Name : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.partsName ?? 'No information',
                  style: normalStyle,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Parts Name : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.partsName ?? 'No information',
                  style: normalStyle,
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Parts Warranty Length : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.partsWarranty + ' Days' ?? 'No information',
                  style: normalStyle,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Secont Parts Name : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.parts2Name ?? 'No information',
                  style: normalStyle,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Secont Parts Warranty Length : ',
                  style: normalStyle,
                ),
                Text(
                  equipDetails.parts2Length ?? 'No information',
                  style: normalStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
