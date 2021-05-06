import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/const/style.dart';
import 'package:warranty_admin/help_center/help_center.dart';
import 'package:warranty_admin/login_screens/login_with_mobile.dart';
import 'package:warranty_admin/provider/auth_service.dart';
import 'package:warranty_admin/registration/registration.dart';
import 'package:warranty_admin/login_screens/reset_password.dart';

class SecondLogin extends StatefulWidget {
  SecondLogin({Key key}) : super(key: key);

  @override
  _SecondLoginState createState() => _SecondLoginState();
}

class _SecondLoginState extends State<SecondLogin> {
  bool _hidePass = true;
  File selectedFile;
  String adminEmailPhone;

  var _passwordController = TextEditingController(text: '123123');

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  //
  @override
  void initState() {
    super.initState();
    _getAdminDetails();
  }

  _getAdminDetails() async {
    await StorageUtils.getAdminEmailPhone().then((emailPhone) {
      adminEmailPhone = emailPhone;
      print("value is ==> $emailPhone");
    });

    Provider.of<AuthService>(context, listen: false)
        .getAdminDetails(adminEmailPhone);
  }

  var baseUrl = 'https://warranty.rbfgroupbd.com/getstaffimage/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Admin Login'),
            centerTitle: true,
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
          ),
          body: (authService.getRes != null)
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Text(authService.getRes.staffID ?? "null"),
                        //Text(adminEmailPhone ?? "null"),
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.only(bottom: 30),
                          child: CircleAvatar(
                            backgroundImage: selectedFile == null
                                ? NetworkImage(
                                    baseUrl + authService.getRes.staffID)
                                : FileImage(selectedFile),
                            backgroundColor: Colors.red,
                            radius: 65,
                          ),
                        ),

                        TextField(
                          controller: _passwordController,
                          obscureText: _hidePass,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(_hidePass
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _hidePass = !_hidePass;
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            print('login password ===> $value');
                          },
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Text('Log in via Mobile'),
                              onTap: () {
                                print('===> inkwell text pressed');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginWithMobile(),
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              child: RichText(
                                text: TextSpan(
                                  text: 'New Admin ?',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Register Now',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Color(0XFF4321F5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print('===> inkwell text pressed');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registration(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
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
                            child: Text(
                              'Log In',
                              style: normalStyle,
                            ),
                            onPressed: () async {
                              setState(() {
                                print('===> login button preesed');
                                if (_passwordController.text.isEmpty) {
                                  print('===> all fields are required');
                                  ToastDisplay.displayMessage(
                                    'all fields are required',
                                    context,
                                  );
                                } else {
                                  setState(() {
                                    _adminLogin(context);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          child: RichText(
                            text: TextSpan(
                              text: 'Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Reset Now',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Color(0XFF4321F5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print('===> inkwell text pressed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPassword(),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 15),
                        InkWell(
                          child: Text('Unable to log in ?', style: smallStyle),
                          onTap: () {
                            print('===> inkwell text pressed');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelpCenter()));
                          },
                        ),

                        //
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  _adminLogin(BuildContext context) async {
    AuthService _authSate = Provider.of<AuthService>(context, listen: false);

    await _authSate.loginUser(
      emailPhone: adminEmailPhone,
      password: _passwordController.text,
      context: context,
    );
  }
}
