import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';

import 'package:warranty_admin/provider/auth_service.dart';

class UpdateItemStatus extends StatefulWidget {
  UpdateItemStatus({Key key}) : super(key: key);

  @override
  _TrackItemStatusState createState() => _TrackItemStatusState();
}

class _TrackItemStatusState extends State<UpdateItemStatus> {
  final _orderController = TextEditingController();
  String _chosenStatus;
  List<DropdownMenuItem<String>> menuitems = [];

  @override
  void dispose() {
    super.dispose();
    _orderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item Status'),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _orderController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Order Number",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          //focusColor: Colors.white,
                          value: _chosenStatus,
                          //elevation: 5,
                          iconSize: 30,
                          items: <String>[
                            'Item received',
                            'Item under investigation',
                            'Item sent to technical team',
                            'Item repaire done',
                            'Item has been sent',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      //color: Colors.redAccent,
                                      // fontSize: ScreenUtil.set(16),
                                      ),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Select Category",
                          ),
                          onChanged: (String value) {
                            setState(
                              () {
                                _chosenStatus = value;
                                print('Selected dropdown ===> $value');
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    child: Text('Update Now'),
                    onPressed: () {
                      print('===> order track button pressed');
                      setState(() {
                        if (_orderController.text.isEmpty) {
                          ToastDisplay.displayMessage(
                              'order id can\'t be empty', context);
                        } else {
                          _updateStatusNow();
                        }
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateStatusNow() async {
    var _postResponse =
        await Provider.of<AuthService>(context, listen: false).updatestatus(
      orderId: _orderController.text,
      status: _chosenStatus,
    );

    print('Status update post response is ===> $_postResponse');

    if (_postResponse is! String) {
      print('successfully updated');
      ToastDisplay.displayMessage('Status successfully updated', context);
    } else {
      print('error');
      ToastDisplay.displayMessage('Something wrong with order Id', context);
    }
  }
}
