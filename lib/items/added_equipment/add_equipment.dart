import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class AddEquipment extends StatefulWidget {
  AddEquipment({Key key}) : super(key: key);

  @override
  _AddEquipmentState createState() => _AddEquipmentState();
}

class _AddEquipmentState extends State<AddEquipment> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool showResetIcon = true;
  DateTime value = DateTime.now();

  bool _validate = false;
  bool _inProcess = false;

  double _currentSliderValue = 20, _currentSliderSubValue = 20;

  final _brandNameController = TextEditingController();
  final _modelNumberController = TextEditingController();
  final _modelNameController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _caterogyController = TextEditingController();
  final _warrantyPeriodController = TextEditingController();

  final _parts1NameController = TextEditingController();
  final _parts1WarrantyController = TextEditingController();
  final _parts2NameController = TextEditingController();
  final _parts2WarrantyController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _brandNameController.dispose();
    _serialNumberController.dispose();
    _modelNumberController.dispose();
    _modelNameController.dispose();
    _caterogyController.dispose();

    _parts1NameController.dispose();
    _parts1WarrantyController.dispose();
    _parts2NameController.dispose();
    _parts2WarrantyController.dispose();
  }

  String _chosenCategory;
  List<DropdownMenuItem<String>> menuitems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
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
              TextField(
                controller: _brandNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Brand Name',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _serialNumberController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serial Number',
                ),
                onChanged: (String value) {
                  print('Serial Number ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _modelNumberController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Model Number',
                ),
                onChanged: (String value) {
                  print('Model Number ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _modelNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Model Name',
                ),
                onChanged: (String value) {
                  print('Model Name ===> $value');
                },
              ),
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
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      //focusColor: Colors.white,
                      value: _chosenCategory,
                      //elevation: 5,
                      iconSize: 30,
                      items: <String>[
                        'Category 1',
                        'Category 2',
                        'Category 3',
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
                            _chosenCategory = value;
                            print('Selected dropdown ===> $value');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _warrantyPeriodController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Warranty Period in days',
                ),
                onChanged: (String value) {
                  print('Warranty Period ===> $value');
                },
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text('Add First Parts Details'),
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _parts1NameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter parts name',
                        ),
                        onChanged: (String value) {
                          print('parts name ===> $value');
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _parts1WarrantyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Parts warranty Period (in days)',
                        ),
                        onChanged: (String value) {
                          print('Parts Warranty Period ===> $value');
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text('Add Second Parts Deatils'),
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _parts2NameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter second parts name',
                        ),
                        onChanged: (String value) {
                          print('parts name ===> $value');
                        },
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _parts2WarrantyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Parts warranty Period (in days)',
                        ),
                        onChanged: (String value) {
                          print('Parts Warranty Period ===> $value');
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  child: Text('Add New Item'),
                  onPressed: () {
                    print('===> add button pressed');
                    if (_brandNameController.text.isEmpty &&
                        _modelNumberController.text.isEmpty &&
                        _warrantyPeriodController.text.isEmpty) {
                      Toast.toast(context, msg: "Required", textSize: 16);
                    } else {
                      setState(() {
                        _addEquipment(context);
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addEquipment(BuildContext context) async {
    var _brandName,
        _modelNumber,
        _modelName,
        _serialNumber,
        _category,
        _warrantyPeriod,
        _parts1Name,
        _parts1Length,
        _parts2Name,
        _parts2Length;

    _brandName = _brandNameController.text;
    _modelNumber = _modelNameController.text;
    _modelName = _modelNameController.text;
    _serialNumber = _serialNumberController.text;
    _category = _chosenCategory;
    _warrantyPeriod = _warrantyPeriodController.text;
    _parts1Name = _parts1NameController.text;
    _parts1Length = _parts1WarrantyController.text;
    _parts2Name = _parts2NameController.text;
    _parts2Length = _parts2WarrantyController.text;

    var _apiResponse =
        await Provider.of<AuthService>(context, listen: false).addEquipment(
      brandName: _brandName,
      modelNumber: _modelNumber,
      modelName: _modelName,
      serialNumber: _serialNumber,
      productType: _category,
      warrantyLength: _warrantyPeriod,
      part1Name: _parts1Name,
      parts1Length: _parts1Length,
      part2Name: _parts2Name,
      parts2length: _parts2Length,
    );
    print('response => $_apiResponse');

    Toast.toast(
      context,
      msg: _apiResponse,
      position: ToastPostion.center,
      textSize: 16,
    );
  }
}
