import 'package:flutter/material.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* Flexible(
                    child: CountryCodePicker(
                      onChanged: print,
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IT',
                      favorite: ['+39', 'FR'],
                      countryFilter: ['IT', 'FR'],
                      showFlagDialog: false,
                      comparator: (a, b) => b.name.compareTo(a.name),
                      //Get the country information relevant to the initial selection
                      onInit: (code) => print(
                          "on init ${code.name} ${code.dialCode} ${code.name}"),
                    ),
                  ), */
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Mobile'),
                    ),
                  )
                ],
              ),
              /* SizedBox(
                width: 400,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CountryCodePicker(
                    onChanged: print,
                    hideMainText: true,
                    showFlagMain: true,
                    showFlag: false,
                    initialSelection: 'TF',
                    hideSearch: true,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: true,
                  ),
                ),
              ), */

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  child: Text('Request for OPT'),
                  onPressed: () {
                    print('===> request for opt button preesed');

                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitOpt(),
                        )); */
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
