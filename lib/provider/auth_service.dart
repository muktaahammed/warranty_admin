import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:warranty_admin/components/toast.dart';
import 'package:warranty_admin/dashboard/official_dash.dart';
import 'package:warranty_admin/login_screens/login_screen.dart';
import 'package:warranty_admin/models/data_model/admin_model.dart';
import 'package:warranty_admin/models/api_model/api_model.dart';
import 'package:warranty_admin/models/api_model/base_mode.dart';
import 'package:warranty_admin/models/data_model/profile_Image_update.dart';
import 'package:warranty_admin/models/data_model/requested_item_details.dart';
import '../models/data_model/admin_model.dart';
import '../models/data_model/requested_item_model.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print('new Auth Service started');
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
      ToastDisplay.displayMessage('Welcome Back', context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OriginalDashBoard(adminEmailPhone: emailPhone),
        ),
      );
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);

      notifyListeners();
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
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
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
    var url = BaseModel.baseUrl + '/staffprofiledetails/$phoneEmail';

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

    var apiUrl = BaseModel.baseUrl + '/editstaff';
    var postResponse = await ApiModel.postJson(params, apiUrl);

    getRes = AdminDataModel(
      name: adminName,
      email: adminEmail,
      phone: adminPhone,
      staffID: adminID,
    );

    print('getting update response ===> $postResponse');

    if (postResponse['code'] == '002') {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    }
    notifyListeners();
  }

  /* 
  * update admin profile image
  * Tested Done 
  need to confirm
  */
  ProfileImageUpdate updateImageResponse;
  Future<void> updateAdminImage({
    String adminID,
    String adminImage,
    BuildContext context,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    var image = await MultipartFile.fromFile(adminImage, filename: adminImage);
    params['staff_id'] = adminID;
    params['staffimage'] = image;

    var apiUrl = BaseModel.baseUrl + '/staffimage';
    var postResponse = await ApiModel.postData(params, apiUrl);
    print('getting post response ===> $postResponse');

    updateImageResponse = ProfileImageUpdate(
      staffDP: adminID,
      staffID: image.toString(),
    );

    if (postResponse['code'] == '002') {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
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
    var url = BaseModel.baseUrl + '/itemnumbers';
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

    var apiResponse = BaseModel.baseUrl + '/updatestatus';
    var postResponse = await ApiModel.postJson(params, apiResponse);
    print('getting registration response ===> $postResponse');

    notifyListeners();
  }
  /* 
  *
  */

  Future registerItemBuyer({
    String serial,
    String product,
    String recipt,
    String buyerPhone,
    String brandName,
    String modelName,
    String modelNumber,
    String serialNumber,
    String category,
    int warrantyLength,
    String buyFrom,
    String contactNumber,
    String purchaseDate,
    String warrantyEnd,
    List subWarranty,
    String alarmTime,
    BuildContext context,
  }) async {
    Map<String, dynamic> formdata = Map<String, dynamic>();

    var serialImage = await MultipartFile.fromFile(serial, filename: serial);
    var productlImage =
        await MultipartFile.fromFile(product, filename: product);
    var reciptImage = await MultipartFile.fromFile(recipt, filename: recipt);

    print(serialImage);
    print(productlImage);
    print(reciptImage);

    formdata['serial'] = serialImage;
    formdata['equipment'] = productlImage;
    formdata['recipt'] = reciptImage;

    formdata['product_model'] = brandName;
    formdata['warrenty_length'] = 30;
    formdata['product_brand'] = modelNumber;
    formdata['buyer_HP'] = buyerPhone;
    formdata['product_type'] = category;
    formdata['product_type'] = category;

    var apiUrl = BaseModel.baseUrl + '/registerequipment';
    var postResponse = await ApiModel.postData(formdata, apiUrl);
    print(postResponse);

    if (postResponse['code'] == '002') {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    }
    notifyListeners();
  }

  //-----------------------------------------

  /* 
  * add equipment by admin
  * Tested Done
  */
  Future addEquipment({
    String brandName,
    String modelName,
    String modelNumber,
    String serialNumber,
    String productType,
    String warrantyLength,
    List subWarranty,
    BuildContext context,
  }) async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params['brand_name'] = brandName;
    params['model_name'] = modelName;
    params['model_number'] = modelNumber;

    params['serial_number'] = serialNumber;
    params['product_type'] = productType;
    params['warrenty_length'] = warrantyLength;
    params['parts_warrenty'] = subWarranty;

    var apiResponse = BaseModel.baseUrl + '/addequipment';
    var postResponse = await ApiModel.postJson(params, apiResponse);
    print('getting registration response ===> $postResponse');

    if (postResponse['code'] == '002') {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      print(postResponse['status'].toString());
      notifyListeners();
    } else {
      ToastDisplay.displayMessage(postResponse['status'].toString(), context);
      notifyListeners();
    }

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
    var url = BaseModel.baseUrl + '/viewequipments';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

    //notifyListeners();
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
    var url = BaseModel.baseUrl + '/activeuser';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item Expired
  * Tested Done
  */
  static Future<Map<String, dynamic>> itemExpired() async {
    var url = BaseModel.baseUrl + '/expireditems';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item under warranty
  */
  static Future<Map<String, dynamic>> itemExpireThisMonth() async {
    var url = BaseModel.baseUrl + '/expirethismonth';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  /* 
  * Item under warranty
  */
  static Future<Map<String, dynamic>> totalUnderWarranty() async {
    var url = BaseModel.baseUrl + '/underwarrenty';
    var getRes = await ApiModel.getJson(url);

    print('getting all active users ===> $getRes');

    return getRes;
  }

  //
  //
  //

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
  * View all items from order table
  */
  static Future<Map<String, dynamic>> viewAllItems() async {
    var url = BaseModel.baseUrl + '/allItems';
    var getRes = await ApiModel.getJson(url);

    print('get added equipment info ===> $getRes');

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
}
