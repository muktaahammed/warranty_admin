import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/dashboard/official_dash.dart';
import 'package:warranty_admin/models/data_model/admin_model.dart';
import 'package:warranty_admin/models/data_model/profile_Image_update.dart';
import 'package:warranty_admin/provider/auth_service.dart';
import 'package:warranty_admin/profile/update_password.dart';

class EditProfile extends StatefulWidget {
  final AdminDataModel updateAdminData;
  final ProfileImageUpdate updatedProfile;
  EditProfile({Key key, @required this.updateAdminData, this.updatedProfile})
      : super(key: key);

  @override
  _EditProfileState createState() =>
      _EditProfileState(updateAdminData, updatedProfile);
}

class _EditProfileState extends State<EditProfile> {
  final AdminDataModel updateAdminData;
  final ProfileImageUpdate updatedProfile;
  _EditProfileState(this.updateAdminData, this.updatedProfile);

  final _adminNameController = TextEditingController();
  final _adminEmailController = TextEditingController();
  final _adminPhoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _adminNameController.dispose();
    _adminEmailController.dispose();
    _adminPhoneController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _adminNameController.text = updateAdminData.name;
    _adminEmailController.text = updateAdminData.email;
    _adminPhoneController.text = updateAdminData.phone;
  }

  File _selectedFile;
  ImagePicker picker = ImagePicker();
  // ignore: unused_field
  bool _inProcess = false;

  var baseURl = 'https://warranty.rbfgroupbd.com/getstaffimage/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Update Profile'),
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    setState(() {
                      _updateAdminDataNow(context);
                    });
                  },
                ),
              ],
            ),
            //Text('Update Profile'),
            centerTitle: true,
            backgroundColor: Colors.green,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OriginalDashBoard(
                          selectedFile: _selectedFile,
                          adminEmailPhone: updateAdminData.staffID,
                        ),
                      ),
                    );
                  });
                }),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      _showOptions(context);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _selectedFile == null
                          ? NetworkImage(
                              baseURl + '${updateAdminData.staffID}',
                            )
                          : FileImage(_selectedFile),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.green[900];
                                return Colors
                                    .green; // Use the component's default.
                              },
                            ),
                          ),
                          child: Text("Update Profile Image"),
                          onPressed: () async {
                            setState(
                              () {
                                if (_selectedFile != null) {
                                  _updateProfileImage(context);
                                } else if (_selectedFile == null) {
                                  ToastDisplay.displayMessage(
                                      'Select a photo first', context);
                                } else {
                                  ToastDisplay.displayMessage(
                                      'Something went wrong with photo',
                                      context);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _adminNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      print('name ===> $value');
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _adminEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (value) {
                      print('email ===> $value');
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _adminPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.call),
                    ),
                    onChanged: (value) {
                      print('phone ===> $value');
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green[900];
                              return Colors
                                  .green; // Use the component's default.
                            },
                          ),
                        ),
                        child: Text('Update Password'),
                        onPressed: () {
                          print('===> update pass has been pressed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePassword(),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getImage(ImageSource source) async {
    /*  this.setState(() {
      _inProcess = true;
    }); */

    PickedFile image = await picker.getImage(source: source);
    setState(() {
      _selectedFile = File(image.path);
      _inProcess = false;
    });

    /*  if (image != null) {
      File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blueAccent,
          toolbarTitle: "RE-SIZER",
          statusBarColor: Colors.lightBlue,
          backgroundColor: Colors.white,
        ),
      );

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    } */
  }

  void _showOptions(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
          ),
          //color: Colors.grey,
          height: 180,
          child: Container(
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
        );
      },
    );
  }

  _updateProfileImage(context) async {
    var _imagePath = _selectedFile.path;
    var converted = _imagePath.toString();

    await Provider.of<AuthService>(context, listen: false).updateAdminImage(
      adminID: updateAdminData.staffID,
      adminImage: converted,
      context: context,
    );
  }

  Future<void> _updateAdminDataNow(context) async {
    var _authService = Provider.of<AuthService>(context, listen: false);

    await _authService.updateAdminData(
      adminName: _adminNameController.text,
      adminEmail: _adminEmailController.text,
      adminPhone: _adminPhoneController.text,
      adminID: updateAdminData.staffID,
      context: context,
    );
  }
}
