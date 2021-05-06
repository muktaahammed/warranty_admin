class ActiveUserList {
  String buyerId;
  String bname;
  String bemail;
  String bphone;
  String joinTime;

  ActiveUserList({
    this.buyerId,
    this.bname,
    this.bemail,
    this.bphone,
    this.joinTime,
  });

  ActiveUserList.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id'];
    bname = json['bname'];
    bemail = json['bemail'];
    bphone = json['bphone'];

    joinTime = json['join_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['bname'] = this.bname;
    data['bemail'] = this.bemail;
    data['bphone'] = this.bphone;
    data['join_time'] = this.joinTime;
    return data;
  }
}
