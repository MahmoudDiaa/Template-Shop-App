import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';

import '../../../../models/category/category_list.dart';
import '../../constants/endpoints.dart';

class CategoryApi {
  final DioClient _dioClient;

  SharedPreferenceHelper sharedPreferenceHelper;

  CategoryApi(
      this._dioClient, SharedPreferenceHelper this.sharedPreferenceHelper);

  /// Returns list of category in response
  Future<CategoryList> getCategories() async {
    try {
      final res = await _dioClient.get(Endpoints.getCategories,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      return CategoryList.fromJson(res['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
