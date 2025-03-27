class Fest {
  int? festID;
  String? festName;
  String? festDetail;
  String? festState;
  int? festNumDay;
  String? festCost;
  int? userID;
  String? festImage;
  // Constructor เอาไว้แพ็คข้อมูล
  Fest({
    this.festID,
    this.festName,
    this.festDetail,
    this.festState,
    this.festNumDay,
    this.festCost,
    this.userID,
    this.festImage,
  });
  // สร้าง Object จาก JSON
  Fest.fromJson(Map<String, dynamic> json) {
    festID = json['festID'];
    festName = json['festName'];
    festDetail = json['festDetail'];
    festState = json['festState'];
    festNumDay = json['festNumDay'];
    festCost = json['festCost'];
    userID = json['userID'];
    festImage = json['festImage'];
  }
  // แปลง Object เป็น JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['festID'] = this.festID;
    data['festName'] = this.festName;
    data['festDetail'] = this.festDetail;
    data['festState'] = this.festState;
    data['festNumDay'] = this.festNumDay;
    data['festCost'] = this.festCost;
    data['userID'] = this.userID;
    data['festImage'] = this.festImage;
    return data;
  }
}
