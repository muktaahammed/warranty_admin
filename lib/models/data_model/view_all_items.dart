class ViewAllItemsModel {
  var id;
  var buyerName;
  var buyerEmail;
  var buyerPhone;
  var buyerId;
  var orderId;
  var brandName;
  var brandModel;
  var warrantyLength;
  var startdate;
  var expireDate;
  var category;
  var parts1Name;
  var parts1Warranty;
  var parts2Name;
  var parts2Warranty;

  ViewAllItemsModel(
    this.id,
    this.buyerName,
    this.buyerEmail,
    this.buyerPhone,
    this.buyerId,
    this.orderId,
    this.brandName,
    this.brandModel,
    this.warrantyLength,
    this.startdate,
    this.expireDate,
    this.category,
    this.parts1Name,
    this.parts1Warranty,
    this.parts2Name,
    this.parts2Warranty,
  );

  ViewAllItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyerName = json['bname'];
    buyerEmail = json['bemail'];
    buyerPhone = json['bphone'];
    buyerId = json['buyer_id'];
    orderId = json['order_id'];
    brandName = json['product_brand'];
    brandModel = json['product_model'];
    warrantyLength = json['warrenty_length'];
    startdate = json['start_date'];
    expireDate = json['expiry_date'];
    category = json['type'];
    parts1Name = json['parts_name'];
    parts1Warranty = json['parts_warrenty'];
    parts2Name = json['part2_name'];
    parts2Warranty = json['parts2_length'];
  }
}
