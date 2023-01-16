import 'package:boilerplate/models/subcategory/subcategory.dart';

import '../../constants/strings.dart';

class Category {
  int? id;
  int? incidentsCount;
  int? subCategoryCount;
  String? arabicName;
  String? englishName;
  String? icon;
  int? order;
  String? color;
  List<SubCategory>? subCategories=[];

  String? localizedName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.englishName;
        break;
      case Strings.arabicCode:
        return this.arabicName;
        break;
    }
    return 'unknown language code';
  }

  Category(
      {this.id,
      this.incidentsCount,
      this.subCategoryCount,
      this.arabicName,
      this.englishName,
      this.icon,
      this.order,
      this.color,
      this.subCategories});

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json['id'],
        incidentsCount: json['incidentsCount'],
        subCategoryCount: json['subCategoryCount'],
        arabicName: json['arabicName'],
        englishName: json['englishName'],
        icon: json['icon'],
        order: json['order'],
        color: json['color'],
        subCategories: (json['subCategoryList'] as List<dynamic>).map((e) => SubCategory.fromMap(e)).toList()
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['incidentsCount'] = this.incidentsCount;
    data['subCategoryCount'] = this.subCategoryCount;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['icon'] = this.icon;
    data['order'] = this.order;
    data['color'] = this.color;
    return data;
  }
}
