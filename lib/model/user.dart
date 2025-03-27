class User {
  int? userID;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userImage;
  // Constructor เอาไว้แพ็คข้อมูล
  User({
    this.userID,
    this.userFullname,
    this.userName,
    this.userPassword,
    this.userImage,
  });
  // สร้าง Object จาก JSON
  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }
  // แปลง Object เป็น JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userFullname'] = this.userFullname;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    return data;
  }
}
