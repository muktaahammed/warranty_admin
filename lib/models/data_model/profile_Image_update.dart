class ProfileImageUpdate {
  String staffID;
  String staffDP;

  ProfileImageUpdate({
    this.staffID,
    this.staffDP,
  });

  ProfileImageUpdate.fromMap(Map<String, dynamic> json)
      : staffID = json['staff_id'],
        staffDP = json['staffimage'];

  Map<String, dynamic> toMap() => {
        'staff_id': staffID,
        'staffimage': staffDP,
      };
}
