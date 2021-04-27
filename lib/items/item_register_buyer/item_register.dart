import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/items/scanner/scanner.dart';
import 'package:warranty_admin/items/sub_warranty/parts_form.dart';
import 'package:warranty_admin/items/sub_warranty/parts_model.dart';
import 'package:warranty_admin/provider/auth_service.dart';

class ItemRegister extends StatefulWidget {
  ItemRegister({Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<ItemRegister> {
  //
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool showResetIcon = true;
  DateTime value = DateTime.now();

  bool _validate = false;
  /* variable for 3 images */
  File _selectedFile, _selectedFile2, _selectedFile3;
  final imagePicker = ImagePicker();
  // ignore: unused_field
  bool _inProcess = false;
  double _currentSliderValue = 20;

  final _buyerMobileController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _modelNameController = TextEditingController();
  final _modelNumberController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _caterogyController = TextEditingController();
  final _warrantyPeriodController = TextEditingController();
  final _buyFromController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _purchesDateController = TextEditingController();
  final _warrantyEndController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _buyerMobileController.dispose();
    _brandNameController.dispose();
    _modelNameController.dispose();
    _modelNumberController.dispose();
    _serialNumberController.dispose();
    _caterogyController.dispose();
    _warrantyPeriodController.dispose();
    _buyFromController.dispose();
    _contactNumberController.dispose();
    _purchesDateController.dispose();
    _warrantyEndController.dispose();
  }

  Future _getImage() async {
    var image;
    image = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = File(image.path);
      print('1st image path ===> $_selectedFile');
    });
  }

  Future _getImage2() async {
    var image2 = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile2 = File(image2.path);
      print('1st image path ===> $_selectedFile2');
    });
  }

  Future _getImage3() async {
    var image3 = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile3 = File(image3.path);
      print('1st image path ===> $_selectedFile3');
    });
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/placeholder.jpg",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  Widget getImageWidget2() {
    if (_selectedFile2 != null) {
      return Image.file(
        _selectedFile2,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/placeholder.jpg",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  Widget getImageWidget3() {
    if (_selectedFile3 != null) {
      return Image.file(
        _selectedFile3,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/placeholder.jpg",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Item'),
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () {
                print('===> scanning for details');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scanner(),
                  ),
                );
              },
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: InkWell(
                        child: getImageWidget(),
                        onTap: () {
                          print('===> 1st image picker has beed pressed');
                          _getImage();
                          //_showPicupDialog();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: InkWell(
                        child: getImageWidget2(),
                        onTap: () {
                          print('===> 2nd image picker has beed pressed');
                          _getImage2();
                          //_showPicupDialog();
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: InkWell(
                        child: getImageWidget3(),
                        onTap: () {
                          print('===> 3rd image picker has beed pressed');
                          _getImage3();
                          //_showPicupDialog();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _buyerMobileController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Buyer Mobile Number',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _brandNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Brand Name',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _modelNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Model Name',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _modelNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Model Number',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _serialNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serial Number',
                ),
                onChanged: (String value) {
                  print('Brand Name ===> $value');
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
                    color: Colors.black45,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      // focusColor: Colors.white,
                      value: _chosenCategory,
                      //elevation: 5,
                      iconSize: 30,
                      items: <String>[
                        'Category 1',
                        'Category 2',
                        'Category 3',
                        'Category 4',
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Warranty Length',
                ),
                onChanged: (String value) {
                  print('Serial Number ===> $value');
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _buyFromController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Buy From',
                      ),
                      onChanged: (String value) {
                        print('Buy From ===> $value');
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: TextField(
                      controller: _contactNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contact Number',
                      ),
                      onChanged: (String value) {
                        print('Contact Number ===> $value');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: DateTimeField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Purchase Date',
                        labelStyle: TextStyle(),
                        errorText: _validate ? 'END TIME ?' : null,
                      ),
                      style: TextStyle(
                          // color: Colors.black,
                          ),
                      controller: _purchesDateController,
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now(),
                            ),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: DateTimeField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Warranty end',
                        labelStyle: TextStyle(),
                        errorText: _validate ? 'END TIME ?' : null,
                      ),
                      controller: _warrantyEndController,
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now(),
                            ),
                          );
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        print('Parts alarm setted is: $value');
                      });
                    },
                  ),
                  Text('Alarm set : $_currentSliderValue days')
                ],
              ),
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
                  onPressed: () async {
                    print('===> add button pressed');
                    registerEquipmentNow(context);
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

  registerEquipmentNow(BuildContext context) async {
    AuthService _authSate = Provider.of<AuthService>(context, listen: false);

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

    //this is array
    print('this is listedd items => $partsList');
    //only for one item
    print('this is type => $subMap');
    //var _warrantyLength = int.parse(_warrantyPeriodController.text);

    await _authSate.registerItemBuyer(
      serial: _selectedFile.path.toString(),
      product: _selectedFile2.path.toString(),
      recipt: _selectedFile3.path.toString(),

      buyerPhone: _buyerMobileController.text,
      brandName: _brandNameController.text,
      modelName: _modelNameController.text,
      modelNumber: _modelNumberController.text,
      serialNumber: _serialNumberController.text,
      category: _chosenCategory,
      warrantyLength: int.parse(_warrantyPeriodController.text),

      buyFrom: _buyFromController.text,
      contactNumber: _contactNumberController.text,
      purchaseDate: _purchesDateController.text,
      warrantyEnd: _warrantyEndController.text,
      subWarranty: partsList,
      alarmTime: _currentSliderValue.toString(),
      context: context,
     
    );
  }

/* 
  void _showPicupDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 180,
          child: Container(
            child: _buildBottomNavigationMenu(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  } */

  /* Column _buildBottomNavigationMenu() {
    return Column(
      children: [
        Center(
          child: Column(
            children: [
              ListTile(
                title: Text('Take Photo'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Pick from Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Cancel'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  } 

  */
}
