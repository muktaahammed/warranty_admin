import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/const/style.dart';
import 'package:warranty_admin/models/data_model/admin_model.dart';
import 'package:warranty_admin/provider/auth_service.dart';

import '../provider/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final AdminDataModel adminProfileData;
  final String staffID;
  ProfileScreen({Key key, @required this.adminProfileData, this.staffID})
      : super(key: key);

  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(adminProfileData, staffID);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AdminDataModel adminProfileData;
  final String staffID;
  _ProfileScreenState(this.adminProfileData, this.staffID);

  @override
  void initState() {
    super.initState();
    getRequestedData();
  }

  getRequestedData() async {
    Provider.of<AuthService>(context, listen: false).requestedItemNumber();
  }

  var baseURl = 'https://warranty.rbfgroupbd.com/getstaffimage/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
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
                            radius: 80,
                            child: CircularProfileAvatar(
                              baseURl + '${authService.getRes.staffID}',
                              errorWidget: (context, url, error) => Container(
                                child: Icon(Icons.error),
                              ),
                              placeHolder: (context, url) => Container(
                                width: 45,
                                height: 45,
                                child: CircularProgressIndicator(),
                              ),
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              borderWidth: 2,
                              borderColor: Colors.blueAccent,
                              elevation: 1.0,
                              cacheImage: true,
                              showInitialTextAbovePicture: false,
                            ),
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
