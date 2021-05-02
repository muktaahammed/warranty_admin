import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:warranty_admin/items/item_register_buyer/item_register.dart';
import 'package:warranty_admin/models/data_model/item_scan_model.dart';

class Scanner extends StatefulWidget {
  Scanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  ItemScanModel _itemScanModel;
  JsonDecoder jsonDecoder;
  bool qrComplete = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: qrComplete
                ? Container(
                    height: 50,
                    child: Center(child: Text('Item Scanned Succesfully')))
                : QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: qrComplete
                  ? Container(
                      child: TextButton(
                        child: Text('Press Here'),
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemRegister(
                              result: _itemScanModel,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text('Scanning....'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        Map<String, dynamic> qrScanData = jsonDecode(scanData.code);
        _itemScanModel = ItemScanModel.fromJson(qrScanData);
        result = scanData;
        qrComplete = true;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}




// {"brand_name":"Brand Name","model_number":"Model Name","model_name":"Model Name","serial_number":"Serial S123","warrenty_length":"25","parts_name":"Parts 1","parts_warrenty":"45","part2_name":"Part 2","parts2_length":"23","product_type":"Category 1"}