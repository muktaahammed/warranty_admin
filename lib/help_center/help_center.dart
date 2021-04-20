import 'package:flutter/material.dart';
import 'package:warranty_admin/const/style.dart';

class HelpCenter extends StatefulWidget {
  HelpCenter({Key key}) : super(key: key);

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
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
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Email : email@mail.com',
                  style: normalStyle,
                ),
                SizedBox(height: 10),
                Text(
                  'Phone : +60187832241',
                  style: normalStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
