
import '../generated/json/base/json_convert_content.dart';
import '../generated/json/base/json_field.dart';

class FavoriteModelEntity with JsonConvert<FavoriteModelEntity> {
	bool? status;
	dynamic message;
	FavoriteModelData? data;
}

class FavoriteModelData with JsonConvert<FavoriteModelData> {
	@JSONField(name: "current_page")
	int? currentPage;
	List<FavoriteModelDataData>? data;
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

class FavoriteModelDataData with JsonConvert<FavoriteModelDataData> {
	int? id;
	FavoriteModelDataDataProduct? product;
}

class FavoriteModelDataDataProduct with JsonConvert<FavoriteModelDataDataProduct> {
	int? id;
	int? price;
	@JSONField(name: "old_price")
	int? oldPrice;
	int? discount;
	String? image;
	String? name;
	String? description;
}
