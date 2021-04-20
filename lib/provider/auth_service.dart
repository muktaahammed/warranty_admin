import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/dashboard/official_dash.dart';
import 'package:warranty_admin/login_screens/login_screen.dart';
import 'package:warranty_admin/models/data_model/admin_model.dart';
import 'package:warranty_admin/models/api_model/api_model.dart';
import 'package:warranty_admin/models/api_model/base_mode.dart';
import 'package:warranty_admin/models/data_model/requested_item_details.dart';
import '../models/data_model/admin_model.dart';
import '../models/data_model/requested_item_model.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print('new Auth Service');
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  /*
  * Login as an Admin
  * Tested Done
   */
  Future loginUser({
    String emailPhone,
    String password,
    BuildContext context,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params['email'] = emailPhone;
    params['password'] = password;

    var apiResponse = BaseModel.baseUrl + '/stafflogin';
    var postResponse = await ApiModel.postJson(params, apiResponse);

    print('getting login response ===> $postResponse');

    if (postResponse['code'] == '002') {
      Toast.toast(
        context,
        msg: 'Welcome Back',
        position: ToastPostion.center,
        textSize: 16,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OriginalDashBoard(adminEmailPhone: emailPhone),
        ),
      );
    } else {
      Toast.toast(
        context,
        msg: postResponse['status'].toString(),
        position: ToastPostion.center,
        textSize: 16,
      );
    }

    notifyListeners();
  }

  /* 
  * Register as an Admin
  * Tested Done
  */
  Future registerUser({
    String name,
    String email,
    String phone,
    String password,
    BuildContext context,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params['name'] = name;
    params['phone'] = email;
    params['email'] = phone;
    params['password'] = password;

    var apiResponse = BaseModel.baseUrl + '/addstaff';
    var postResponse = await ApiModel.postJson(params, apiResponse);
    print('getting registration response ===> $postResponse');

    if (postResponse['code'] == '002') {
      Toast.toast(
        context,
        msg: postResponse['status'].toString(),
        textSize: 16,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      notifyListeners();
    } else {
      Toast.toast(
        context,
        msg: postResponse['status'].toString(),
        textSize: 16,
      );
      notifyListeners();
    }

    notifyListeners();
  }

  /*
    * get admin information
    * Tested Done
  */
  AdminDataModel getRes;
  Future<void> getAdminDetails(String phoneEmail) async {
    var url = BaseModel.baseUrl + '/staffProfile/$phoneEmail';

    var getResponse = await ApiModel.getJson(url);
    getRes = AdminDataModel.fromJson(getResponse);

    print('get admin info ===> $getResponse');
    print('geting admin email or phone : $phoneEmail');

    notifyListeners();
  }

  /* 
  * update admin information
  * Tested Done
  */
  Future<void> updateAdminData({
    String adminName,
    String adminEmail,
    String adminPhone,
    String adminID,
    BuildContext context,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['name'] = adminName;
    params['email'] = adminEmail;
    params['phone'] = adminPhone;
    params['staff_id'] = adminID;

    var apiUrl = BaseModel.baseUrl + '/editStaff';
    var postResponse = await ApiModel.postJson(params, apiUrl);

    getRes = AdminDataModel(
      name: adminName,
      email: adminEmail,
      phone: adminPhone,
      id: adminID,
    );

    print('getting update response ===> $postResponse');

    if (postResponse['code'] == '002') {
      Toast.toast(
        context,
        msg: postResponse['status'].toString(),
        textSize: 16,
      );
    } else {
      Toast.toast(
        context,
        msg: postResponse['status'].toString(),
        textSize: 16,
      );
    }
    notifyListeners();
  }

  ///
  Future<void> updateAdminImage(String adminID, File adminImage) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    Dio dio = new Dio();
    params['staff_id'] = adminID;
    params['staffDP'] = adminImage;

    var apiUrl = BaseModel.baseUrl + '/staffDP';
 
    var postResponse = await ApiModel.postData(params, apiUrl);
    print('getting post response===> $postResponse');

    if (postResponse == '002') {
      print('successfully update');
    } else {
      print('Erroe to update');
    }

    notifyListeners();
  }
  /* End of Admin */

  /* 
  * requested item from warranty and their number
  * Tested Done 
  */
  RequestedItemModel requestedNumber;
  Future<void> requestedItemNumber() async {
    var url = BaseModel.baseUrl + '/requestedProducts';
    var getRes = await ApiModel.getJson(url);

    print('get requested item list ===> $getRes');
    requestedNumber = RequestedItemModel.fromJson(getRes);
    print(requestedNumber);

    notifyListeners();
  }

  /* 
  * requested item from warranty and their Details
  * Tested Done 
  */
  RequestedItemDetails requestedDetail;
  Future<void> requestedItemDetails() async {
    var url = BaseModel.baseUrl + '/requestedProducts';
    var getRes = await ApiModel.getJson(url);

    print('get requested item list ===> $getRes');
    requestedDetail = RequestedItemDetails.fromJson(getRes);
    print(requestedDetail);

    notifyListeners();
  }

  /* 
  * update status of requested warranty 
  * Tested Done 
  */
  Future updatestatus({String orderId, String status}) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['order_id'] = orderId;
    params['status'] = status;

    var apiResponse = BaseModel.baseUrl + '/updateStatus';
    var postResponse = await ApiModel.postJson(params, apiResponse);
    print('getting registration response ===> $postResponse');

    /* postResponse = RequestedItemDetails(
      requestedDetail.id,
      requestedDetail.email,
      requestedDetail.phone,
      requestedDetail.name,
      requestedDetail.dob,
      requestedDetail.buyerId,
      requestedDetail.gender,
      requestedDetail.joinDate,
      requestedDetail.photo,
      requestedDetail.orderId,
      requestedDetail.stage0,
      requestedDetail.stage1,
      requestedDetail.stage2,
      requestedDetail.stage3,
      requestedDetail.stage4,
      requestedDetail.stage5,
    ); */

    notifyListeners();
  }
  /* 
  *
   */

  Future registerItemBuyer({
    String serial,
    String product,
    String recipt,
    String brandName,
    String serialNumber,
    String modelNumber,
    String modelName,
    String category,
    int warrantyLength,
    String parts1Name,
  }) async {
    Map<String, dynamic> formdata = Map<String, dynamic>();
    formdata[''] = serial;
    formdata[''] = product;
    formdata[''] = recipt;
    formdata[''] = brandName;
    formdata[''] = serialNumber;
    formdata[''] = modelNumber;
    formdata[''] = modelName;
    formdata[''] = category;
    formdata[''] = warrantyLength;
    var apiUrl = BaseModel.baseUrl + '/registerEquipment';
    var postResponse = await ApiModel.postJson(formdata, apiUrl);
    print(postResponse);

    notifyListeners();
  }

  //-----------------------------------------

  /* 
  * add equipment by admin
  * Tested Done
  */
  Future addEquipment({
    String brandName,
    String modelNumber,
    String modelName,
    String serialNumber,
    String productType,
    String warrantyLength,
    String part1Name,
    String parts1Length,
    String part2Name,
    String parts2length,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params['brand_name'] = brandName;
    params['model_number'] = modelNumber;
    params['model_name'] = modelName;
    params['serial_number'] = serialNumber;
    params['product_type'] = productType;
    params['warrenty_length'] = warrantyLength;

    params['part1_name'] = part1Name;
    params['part1_length'] = parts1Length;
    params['part2_name'] = part2Name;
    params['parts2_length'] = parts2length;

    var apiResponse = BaseModel.baseUrl + '/addEquipment';
    var postResponse = await ApiModel.postJson(params, apiResponse);
    print('getting registration response ===> $postResponse');

    notifyListeners();
  }

  //########################################//
  //         without provider               //
  // #######################################//

  /*
  * View the added equipment by admin 
  * Tested Done
  */
  //ViewEquipments getEquipmentRes;
  static Future<Map<String, dynamic>> viewAddedEquipments() async {
    var url = BaseModel.baseUrl + '/viewEquipments';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

    //notifyListeners();
    return getRes;
  }

  /*
  * View the added equipment by admin on behalf of buyer
  */
  static Future<Map<String, dynamic>> viewRegisterEquipments() async {
    var url = BaseModel.baseUrl + '/registerEquipment';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

    return getRes;
  }

  /*
  * View all items from order table
  */
  static Future<Map<String, dynamic>> viewAllItems() async {
    var url = BaseModel.baseUrl + '/allItems';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

    return getRes;
  }

  static Future<Map<String, dynamic>> viewRequestedItems() async {
    var url = BaseModel.baseUrl + '/requestProductList';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

    return getRes;
  }

  /* 
  * All active users
  * Tested Done
  */
  static Future<Map<String, dynamic>> activeUsers() async {
    var url = BaseModel.baseUrl + '/activeUser';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item Expired
  * Tested Done
  */
  static Future<Map<String, dynamic>> itemExpired() async {
    var url = BaseModel.baseUrl + '/expiredItems';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item under warranty
  */
  static Future<Map<String, dynamic>> itemExpireThisMonth() async {
    var url = BaseModel.baseUrl + '/expireThisMonth';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item under warranty
  */
  static Future<Map<String, dynamic>> onWarrantyProcess() async {
    var url = BaseModel.baseUrl + '/sentToTechnical';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item under warranty
  */
  static Future<Map<String, dynamic>> totalUnderWarranty() async {
    var url = BaseModel.baseUrl + '/warrenty';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }
}
