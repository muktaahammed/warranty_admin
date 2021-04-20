import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/requested_item_details.dart';

class RequestedDetails extends StatefulWidget {
  final RequestedItemDetails requestedDetails;
  RequestedDetails({Key key, @required this.requestedDetails})
      : super(key: key);

  @override
  _RequestedDetailsState createState() =>
      _RequestedDetailsState(requestedDetails);
}

class _RequestedDetailsState extends State<RequestedDetails> {
  RequestedItemDetails requestedDetails;
  _RequestedDetailsState(this.requestedDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requested Item Deatils'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(requestedDetails.buyerId),
              Text(requestedDetails.name),
              Text(requestedDetails.phone),
            ],
          ),
        ),
      ),
    );
  }
}
