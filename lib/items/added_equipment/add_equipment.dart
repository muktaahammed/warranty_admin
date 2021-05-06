import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/items/sub_warranty/parts_form.dart';
import 'package:warranty_admin/items/sub_warranty/parts_model.dart';
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

  // ignore: unused_field
  bool _validate = false;
  // ignore: unused_field
  bool _inProcess = false;

  // ignore: unused_field
  double _currentSliderValue = 20, _currentSliderSubValue = 20;

  final _brandNameController = TextEditingController();
  final _modelNameController = TextEditingController();
  final _modelNumberController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _caterogyController = TextEditingController();
  final _warrantyPeriodController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _brandNameController.dispose();
    _serialNumberController.dispose();
    _modelNameController.dispose();
    _modelNumberController.dispose();
    _caterogyController.dispose();
  }

  String _chosenCategory;
  List<DropdownMenuItem<String>> menuitems = [];

  // form widget as a list
  List<PartsForm> partsForm = [];

  //on form user deleted
  void onDelete(PartsModel _partsModel) {
    setState(() {
      var find = partsForm.firstWhere(
        (it) => it.partsModel == _partsModel,
        orElse: () => null,
      );
      if (find != null) partsForm.removeAt(partsForm.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _partsModel = PartsModel();
      partsForm.add(PartsForm(
        partsModel: _partsModel,
        onDelete: () => onDelete(_partsModel),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Equipment Item'),
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

              //add parts in json
              ExpansionTile(
                title: Text('Add a new parts'),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Press + button to add a new parts'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: onAddForm,
                      )
                    ],
                  ),
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    child: partsForm.length <= 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No Parts added'),
                            ],
                          )
                        : ListView.builder(
                            addAutomaticKeepAlives: true,
                            itemCount: partsForm.length,
                            itemBuilder: (_, i) => partsForm[i],
                          ),
                  ),
                ],
              ),
              //add parts in json

              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green[900];
                        return Colors.green; // Use the component's default.
                      },
                    ),
                  ),
                  child: Text('Add New Item'),
                  onPressed: () {
                    print('===> add button pressed');
                    if (_brandNameController.text.isEmpty &&
                        _modelNumberController.text.isEmpty &&
                        _warrantyPeriodController.text.isEmpty) {
                      ToastDisplay.displayMessage(
                          'All fields are required', context);
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
    var _authService = Provider.of<AuthService>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 45,
            width: 45,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    //nested json post
    Map<String, dynamic> subMap;
    List partsList = [];
    for (int i = 0; i < partsForm.length; i++) {
      partsForm[i].validate();
      subMap = Map();
      subMap['parts_name'] = '${partsForm[i].partsModel.partsName}';
      subMap['purches_date'] = '${partsForm[i].partsModel.purchesDate}';
      subMap['warranty_end'] = '${partsForm[i].partsModel.warrantyEnd}';
      subMap['alarm_date'] = '${partsForm[i].partsModel.alarmDate}';
      partsList.add(subMap);
    }
    print('this is listedd items => $partsList');
    //only for
    print('this is type => $subMap');

    await _authService.addEquipment(
      brandName: _brandNameController.text,
      modelName: _modelNameController.text,
      modelNumber: _modelNameController.text,
      serialNumber: _serialNumberController.text,
      productType: _chosenCategory,
      warrantyLength: _warrantyPeriodController.text,
      subWarranty: partsList,
      context: context,
    );
  }
}
