import '../../constants/strings.dart';

class SubCategory {
  int? id;
  int? incidentsCount;
  int? categoryId;
  String? icon;
  int? amountUnitId;
  String? amountUnitArabicName;
  String? amountUnitEnglishName;
  String? categoryArabicName;
  String? categoryEnglishName;
  String? arabicName;
  String? englishName;
  int? mainCategoryId;
  int? order;
  String? color;
  String? file;

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

  String? localizedCategoryName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.categoryEnglishName;
        break;
      case Strings.arabicCode:
        return this.categoryArabicName;
        break;
    }
    return 'unknown language code';
  }
  String? localizedUnitName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.amountUnitEnglishName;
        break;
      case Strings.arabicCode:
        return this.amountUnitArabicName;
        break;
    }
    return 'unknown language code';
  }

  SubCategory(
      {this.id,
      this.incidentsCount,
      this.categoryId,
      this.icon,
      this.amountUnitId,
      this.amountUnitArabicName,
      this.amountUnitEnglishName,
      this.categoryArabicName,
      this.categoryEnglishName,
      this.arabicName,
      this.englishName,
      this.mainCategoryId,
      this.order,
      this.color,
      this.file});

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json['id'],
        incidentsCount: json['incidentsCount'],
        categoryId: json['categoryId'],
        icon: json['icon'],
        amountUnitId: json['amountUnitId'],
        amountUnitArabicName: json['amountUnitArabicName'],
        amountUnitEnglishName: json['amountUnitEnglishName'],
        categoryArabicName: json['categoryArabicName'],
        categoryEnglishName: json['categoryEnglishName'],
        arabicName: json['arabicName'],
        englishName: json['englishName'],
        mainCategoryId: json['mainCategoryId'],
        order: json['order'],
        color: json['color'],
        file: json['file'],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['incidentsCount'] = this.incidentsCount;
    data['categoryId'] = this.categoryId;
    data['icon'] = this.icon;
    data['amountUnitId'] = this.amountUnitId;
    data['amountUnitArabicName'] = this.amountUnitArabicName;
    data['amountUnitEnglishName'] = this.amountUnitEnglishName;
    data['categoryArabicName'] = this.categoryArabicName;
    data['categoryEnglishName'] = this.categoryEnglishName;
    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;
    data['mainCategoryId'] = this.mainCategoryId;
    data['order'] = this.order;
    data['color'] = this.color;
    data['file'] = this.file;
    return data;
  }
}
