class DataModel {
  late String name;
  late String uId;

  DataModel(this.name, this.uId);

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "uid": uId};
  }
}
