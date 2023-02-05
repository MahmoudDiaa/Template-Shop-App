
import '../../model/search_products_model_entity.dart';

searchProductsModelEntityFromJson(SearchProductsModelEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'];
	}
	if (json['data'] != null) {
		data.data = SearchProductsModelData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> searchProductsModelEntityToJson(SearchProductsModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['message'] = entity.message;
	data['data'] = entity.data?.toJson();
	return data;
}

searchProductsModelDataFromJson(SearchProductsModelData data, Map<String, dynamic> json) {
	if (json['current_page'] != null) {
		data.currentPage = json['current_page'] is String
				? int.tryParse(json['current_page'])
				: json['current_page'].toInt();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => ProductData().fromJson(v)).toList();
	}
	if (json['first_page_url'] != null) {
		data.firstPageUrl = json['first_page_url'].toString();
	}
	if (json['from'] != null) {
		data.from = json['from'] is String
				? int.tryParse(json['from'])
				: json['from'].toInt();
	}
	if (json['last_page'] != null) {
		data.lastPage = json['last_page'] is String
				? int.tryParse(json['last_page'])
				: json['last_page'].toInt();
	}
	if (json['last_page_url'] != null) {
		data.lastPageUrl = json['last_page_url'].toString();
	}
	if (json['next_page_url'] != null) {
		data.nextPageUrl = json['next_page_url'];
	}
	if (json['path'] != null) {
		data.path = json['path'].toString();
	}
	if (json['per_page'] != null) {
		data.perPage = json['per_page'] is String
				? int.tryParse(json['per_page'])
				: json['per_page'].toInt();
	}
	if (json['prev_page_url'] != null) {
		data.prevPageUrl = json['prev_page_url'];
	}
	if (json['to'] != null) {
		data.to = json['to'] is String
				? int.tryParse(json['to'])
				: json['to'].toInt();
	}
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	return data;
}

Map<String, dynamic> searchProductsModelDataToJson(SearchProductsModelData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['current_page'] = entity.currentPage;
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	data['first_page_url'] = entity.firstPageUrl;
	data['from'] = entity.from;
	data['last_page'] = entity.lastPage;
	data['last_page_url'] = entity.lastPageUrl;
	data['next_page_url'] = entity.nextPageUrl;
	data['path'] = entity.path;
	data['per_page'] = entity.perPage;
	data['prev_page_url'] = entity.prevPageUrl;
	data['to'] = entity.to;
	data['total'] = entity.total;
	return data;
}

ProductDataFromJson(ProductData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['description'] != null) {
		data.description = json['description'].toString();
	}
	if (json['images'] != null) {
		data.images = (json['images'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['in_favorites'] != null) {
		data.inFavorites = json['in_favorites'];
	}
	if (json['in_cart'] != null) {
		data.inCart = json['in_cart'];
	}
	return data;
}

Map<String, dynamic> ProductDataToJson(ProductData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['price'] = entity.price;
	data['image'] = entity.image;
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['images'] = entity.images;
	data['in_favorites'] = entity.inFavorites;
	data['in_cart'] = entity.inCart;
	return data;
}