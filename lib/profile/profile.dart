import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/const/style.dart';
import 'package:warranty_admin/models/data_model/admin_model.dart';
import 'package:warranty_admin/provider/auth_service.dart';
import '../provider/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final File selectedFile;
  final AdminDataModel adminProfileData;

  ProfileScreen({Key key, @required this.adminProfileData, this.selectedFile})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(adminProfileData);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AdminDataModel adminProfileData;

  var _networkImage;
  _ProfileScreenState(this.adminProfileData);

  @override
  void initState() {
    super.initState();
  }

  var baseURl = 'https://warranty.rbfgroupbd.com/getstaffimage/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      _networkImage = widget.selectedFile == null
          ? NetworkImage(baseURl + authService.getRes.staffID)
          : FileImage(widget.selectedFile);
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Admin Profile'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body:
            (authService.getRes != null && authService.requestedNumber != null)
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.grey[200],
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CircleAvatar(
                            backgroundImage: _networkImage,
                            backgroundColor: Colors.transparent,
                            radius: 80,
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Name : ',
                                      style: normalStyle,
                                    ),
                                    Text(
                                      authService.getRes.name,
                                      style: normalStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Email :  ',
                                      style: normalStyle,
                                    ),
                                    Text(
                                      authService.getRes.email,
                                      style: smallStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Phone : ',
                                      style: normalStyle,
                                    ),
                                    Text(
                                      authService.getRes.phone,
                                      style: smallStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //sws
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      );
    });
  }
}
