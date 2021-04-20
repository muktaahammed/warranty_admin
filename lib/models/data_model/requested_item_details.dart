class RequestedItemDetails {
  int id;
  String email;
  String phone;
  String name;
  String dob;
  String buyerId;
  String gender;
  String joinDate;
  String photo;
  String orderId;
  String stage0;
  String stage1;
  String stage2;
  String stage3;
  String stage4;
  String stage5;
  RequestedItemDetails(
    this.id,
    this.email,
    this.phone,
    this.name,
    this.dob,
    this.buyerId,
    this.gender,
    this.joinDate,
    this.photo,
    this.orderId,
    this.stage0,
    this.stage1,
    this.stage2,
    this.stage3,
    this.stage4,
    this.stage5,
  );
  RequestedItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['bemail'];
    phone = json['bphone'];
    name = json['bname'];
    dob = json['bdob'];
    buyerId = json['buyer_id'];
    gender = json['bgender'];
    joinDate = json['join_time'];
    photo = json['photo'];
    orderId = json['order_id'];
    stage0 = json['stage0'];
    stage1 = json['stage1'];
    stage2 = json['stage2'];
    stage3 = json['stage3'];
    stage4 = json['stage4'];
    stage5 = json['stage5'];
  }
}
