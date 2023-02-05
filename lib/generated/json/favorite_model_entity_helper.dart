
import '../../model/favorite_model_entity.dart';

favoriteModelEntityFromJson(FavoriteModelEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['message'] != null) {
		data.message = json['message'];
	}
	if (json['data'] != null) {
		data.data = FavoriteModelData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> favoriteModelEntityToJson(FavoriteModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	data['message'] = entity.message;
	data['data'] = entity.data?.toJson();
	return data;
}

favoriteModelDataFromJson(FavoriteModelData data, Map<String, dynamic> json) {
	if (json['current_page'] != null) {
		data.currentPage = json['current_page'] is String
				? int.tryParse(json['current_page'])
				: json['current_page'].toInt();
	}
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => FavoriteModelDataData().fromJson(v)).toList();
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

Map<String, dynamic> favoriteModelDataToJson(FavoriteModelData entity) {
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

favoriteModelDataDataFromJson(FavoriteModelDataData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['product'] != null) {
		data.product = FavoriteModelDataDataProduct().fromJson(json['product']);
	}
	return data;
}

Map<String, dynamic> favoriteModelDataDataToJson(FavoriteModelDataData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product'] = entity.product?.toJson();
	return data;
}

favoriteModelDataDataProductFromJson(FavoriteModelDataDataProduct data, Map<String, dynamic> json) {
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
	if (json['old_price'] != null) {
		data.oldPrice = json['old_price'] is String
				? int.tryParse(json['old_price'])
				: json['old_price'].toInt();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'] is String
				? int.tryParse(json['discount'])
				: json['discount'].toInt();
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
	return data;
}

Map<String, dynamic> favoriteModelDataDataProductToJson(FavoriteModelDataDataProduct entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['price'] = entity.price;
	data['old_price'] = entity.oldPrice;
	data['discount'] = entity.discount;
	data['image'] = entity.image;
	data['name'] = entity.name;
	data['description'] = entity.description;
	return data;
}