class AddDataModel {
  int? id;
  String? addDataUserId;
  String? date;
  String? time;
  String? type;
  String? category;
  String? paymentMethod;
  String? status;
  String? note;

  AddDataModel(
      {this.id,
      this.addDataUserId,
      this.date,
      this.time,
      this.type,
      this.category,
      this.paymentMethod,
      this.status,
      this.note});

  AddDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addDataUserId = json['addDataUserId'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    category = json['category'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addDataUserId'] = addDataUserId;
    data['date'] = date;
    data['time'] = time;
    data['type'] = type;
    data['category'] = category;
    data['paymentMethod'] = paymentMethod;
    data['status'] = status;
    data['note'] = note;
    return data;
  }
}
