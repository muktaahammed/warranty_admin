import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/items/added_equipment/add_equipment.dart';
import 'package:warranty_admin/items/all_items/view_all_items_list.dart';
import 'package:warranty_admin/items/item_register_buyer/item_register.dart';
import 'package:warranty_admin/items/added_equipment/view_equipment_list.dart';
import 'package:warranty_admin/items/manual_status/item_status.dart';
import 'package:warranty_admin/items/requested_warranty/requested_warranty_list.dart';
import 'package:warranty_admin/profile/profile.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class MaindashBoard extends StatefulWidget {
  final String adminEmailPhone;
  MaindashBoard({Key key, @required this.adminEmailPhone}) : super(key: key);

  @override
  _MaindashBoardState createState() => _MaindashBoardState(adminEmailPhone);
}

class _MaindashBoardState extends State<MaindashBoard> {
  final String adminEmailPhone;
  _MaindashBoardState(this.adminEmailPhone);

  @override
  void initState() {
    super.initState();
    getAdminDetails();
  }

  getAdminDetails() async {
    Provider.of<AuthService>(context, listen: false)
        .getAdminDetails(adminEmailPhone);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dashboard'),
                IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      /*  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatHomePage())); */
                    })
              ],
            ),
            backgroundColor: Colors.green,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://warranty.rbfgroupbd.com/getstaffDP/${authService.getRes.staffID}'),
                      backgroundColor: Colors.transparent,
                      radius: 90,
                    ),
                    onTap: () {
                      print('===> peofile button preesed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            adminProfileData: authService.getRes,
                          ),
                        ),
                      );
                      print(authService.getRes.email);
                    },
                  ),
                  //Text(adminData.message),
                  SizedBox(height: 5),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('View All Iteams'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('===> iteam arrow preesed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllItemsList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('View Added Equipments'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('===> iteam arrow preesed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAddedEquipment(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Add Equipment'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('===> add iteam arrow preesed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEquipment(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Add Item of Buyer'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('===> add iteam arrow preesed');
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemRegister(),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Requested Item for Warranty'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('===> add iteam arrow preesed');
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewRequestedList(),
                                //RequestedWarrantyList(),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Update warranty status'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateItemStatus(),
                              ),
                            );
                          });
                          print('===> update item status arrow preesed');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
