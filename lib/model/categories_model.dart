class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<Categories>? data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    this.currentPage = json['current_page'];
    json['data'].forEach((element) {
      data!.add(Categories.formJson(element));
    });
  }
}

class Categories {
  int? id;

  String? name;
  String? image;

  Categories.formJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.image = json['image'];
  }
}
