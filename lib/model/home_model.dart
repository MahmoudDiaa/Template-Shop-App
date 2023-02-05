class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.formJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel>? banners = [];
  List<ProductsModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    print('products ${json['products']}');
    json['products'].forEach((elements) {
      products!.add(ProductsModel.fromJson(elements));
    });
    json['banners'].forEach((elements) {
      banners!.add(BannersModel.fromJson(elements));
    });
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavourites;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
