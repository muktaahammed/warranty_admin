import 'package:flutter/material.dart';
import 'package:warranty_admin/login_screens/confirm_opt.dart';

class LoginWithMobile extends StatefulWidget {
  LoginWithMobile({Key key}) : super(key: key);

  @override
  _LoginWithMobileState createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login with mobile',
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                  hintText: '+6018783241',
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.green,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: IconButton(
                    icon: Icon(
                      Icons.forward_sharp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('requested for opt');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmOtp(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
