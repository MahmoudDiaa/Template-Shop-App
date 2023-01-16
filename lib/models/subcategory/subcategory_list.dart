import 'package:boilerplate/models/subcategory/subcategory.dart';
import 'package:boilerplate/models/subcategory/subcategory_query_params.dart';

class SubCategoryList {
  List<SubCategory> subcategories;

  SubCategoryList({
    required this.subcategories,
  });

  bool get isThereData {
    return this.subcategories != null && this.subcategories!.length > 0;
  }

  SubCategoryList filtered(SubCategoryQueryParams filter) {
    if (this.subcategories == null)
      return SubCategoryList(subcategories: []);
    else
      return SubCategoryList(
          subcategories: this
              .subcategories!
              .where((element) => (filter.categoryId == null ||
                  filter.categoryId == element.categoryId))
              .toList());
  }

  factory SubCategoryList.fromJson(List<dynamic> json) {
    List<SubCategory> subcategories = <SubCategory>[];
    subcategories = json.map((post) => SubCategory.fromMap(post)).toList();

    return SubCategoryList(
      subcategories: subcategories,
    );
  }
}
