class ActiveUserList {
  //int activeUser;
  String bname;
  String bemail;
  String bphone;
  String buyerId;
  String joinTime;

  ActiveUserList({
    //this.activeUser,
    this.bname,
    this.bemail,
    this.bphone,
    this.buyerId,
    this.joinTime,
  });

  ActiveUserList.fromJson(Map<String, dynamic> json) {
    //activeUser = json['total_active_user'];
    bname = json['bname'];
    bemail = json['bemail'];
    bphone = json['bphone'];
    buyerId = json['buyer_id'];
    joinTime = json['join_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['total_active_user'] = this.activeUser;
    data['bname'] = this.bname;
    data['bemail'] = this.bemail;
    data['bphone'] = this.bphone;
    data['buyer_id'] = this.buyerId;
    data['join_time'] = this.joinTime;
    return data;
  }
}
