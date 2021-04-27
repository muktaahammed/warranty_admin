import 'package:flutter/material.dart';

class ConfirmOtp extends StatefulWidget {
  ConfirmOtp({Key key}) : super(key: key);

  @override
  _ConfirmOtpState createState() => _ConfirmOtpState();
}

class _ConfirmOtpState extends State<ConfirmOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm OTP',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Submit the OTP',
                hintText: '783241',
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.green,
              child: SizedBox(
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
                  child: Text('Login Now'),
                  onPressed: () {
                    print('===> request for opt button preesed');
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (),
                        )); */
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
