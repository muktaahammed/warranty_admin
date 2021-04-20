import 'package:flutter/material.dart';
import 'package:warranty_admin/models/data_model/active_user_model.dart';

class UsersDeatils extends StatefulWidget {
  final ActiveUserList usersDeatils;
  UsersDeatils({Key key, @required this.usersDeatils}) : super(key: key);

  @override
  _UsersDeatilsState createState() => _UsersDeatilsState(usersDeatils);
}

class _UsersDeatilsState extends State<UsersDeatils> {
  ActiveUserList usersDeatils;
  _UsersDeatilsState(this.usersDeatils);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active User Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(usersDeatils.bemail),
          ],
        ),
      ),
    );
  }
}
