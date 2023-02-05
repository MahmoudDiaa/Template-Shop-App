

import '../generated/json/base/json_convert_content.dart';
import '../generated/json/base/json_field.dart';

class SearchProductsModelEntity with JsonConvert<SearchProductsModelEntity> {
	bool? status;
	dynamic message;
	SearchProductsModelData? data;
}

class SearchProductsModelData with JsonConvert<SearchProductsModelData> {
	@JSONField(name: "current_page")
	int? currentPage;
	List<ProductData>? data;
	@JSONField(name: "first_page_url")
	String? firstPageUrl;
	int? from;
	@JSONField(name: "last_page")
	int? lastPage;
	@JSONField(name: "last_page_url")
	String? lastPageUrl;
	@JSONField(name: "next_page_url")
	dynamic nextPageUrl;
	String? path;
	@JSONField(name: "per_page")
	int? perPage;
	@JSONField(name: "prev_page_url")
	dynamic prevPageUrl;
	int? to;
	int? total;
}

class ProductData with JsonConvert<ProductData> {
	int? id;
	int? price;
	String? image;
	String? name;
	String? description;
	List<String>? images;
	@JSONField(name: "in_favorites")
	bool? inFavorites;
	@JSONField(name: "in_cart")
	bool? inCart;
}
