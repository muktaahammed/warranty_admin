import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/const/style.dart';
import 'package:warranty_admin/help_center/help_center.dart';
import 'package:warranty_admin/login_screens/login_with_mobile.dart';
import 'package:warranty_admin/provider/auth_service.dart';
import 'package:warranty_admin/registration/registration.dart';
import '../provider/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePass = true;

  final _emailPhoneContoller = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailPhoneContoller.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.grey[200],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: _emailPhoneContoller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email or Phone',
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (String value) {
                      print('login email or phone ===> $value');
                    },
                  ),
                ),

                //Spacer(),
                SizedBox(height: 10),
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
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      icon: Icon(
                          _hidePass ? Icons.visibility_off : Icons.visibility),
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
                SizedBox(height: 20),
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
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Register Now',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0XFF4321F5)),
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
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
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
                    child: Text(
                      'Log In',
                      style: normalStyle,
                    ),
                    onPressed: () async {
                      setState(() {
                        print('===> login button preesed');
                        if (_emailPhoneContoller.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          print('===> all fields are required');
                          ToastDisplay.displayMessage(
                              'all fields are required', context);
                        } else {
                          _adminLogin(context);
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  child: Text('Unable to log in ?', style: smallStyle),
                  onTap: () {
                    print('===> inkwell text pressed');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpCenter()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _adminLogin(BuildContext context) async {
    var adminEmailPhone, _adminPassword;

    adminEmailPhone = _emailPhoneContoller.text;
    _adminPassword = _passwordController.text;

    AuthService _authSate = Provider.of<AuthService>(context, listen: false);

    await _authSate.loginUser(
      emailPhone: adminEmailPhone,
      password: _adminPassword,
      context: context,
    );

    print('parsing value ===> $adminEmailPhone');
  }
}
