import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warranty_admin/const/style.dart';
import 'package:warranty_admin/models/data_model/view_all_items.dart';

class AllItemsDetails extends StatefulWidget {
  final ViewAllItemsModel allItemDetails;
  AllItemsDetails({Key key, @required this.allItemDetails}) : super(key: key);

  @override
  _AllItemsState createState() => _AllItemsState(allItemDetails);
}

class _AllItemsState extends State<AllItemsDetails> {
  final ViewAllItemsModel allItemDetails;

  _AllItemsState(this.allItemDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Items Details'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.grey[200],
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    allItemDetails.brandName,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.buyerEmail,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.buyerPhone,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.buyerId,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.brandName,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.brandModel,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.warrantyLength.toString(),
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.startdate,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.expireDate,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.category,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.parts1Name,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.parts1Warranty,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.parts2Name,
                    style: normalStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    allItemDetails.parts2Warranty,
                    style: normalStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
