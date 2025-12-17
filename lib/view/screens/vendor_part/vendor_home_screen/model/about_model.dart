class VendorAboutUsModel {
  String? id;
  String? description;

  VendorAboutUsModel({this.id, this.description});

  VendorAboutUsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description']; // API তে যদি content বা text নামে আসে, সেই অনুযায়ী নাম দিবেন
  }
}