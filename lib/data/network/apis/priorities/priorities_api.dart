import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/PriorityLevels%20/Priority_level_list.dart';
import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../rest_client.dart';

class prioritiesApi{

// dio instance
  final DioClient _dioClient;

  // rest-client instance
  SharedPreferenceHelper _sharedPreferenceHelper;

  prioritiesApi(this._dioClient, this._sharedPreferenceHelper);



  /// Returns list of priorities level
  Future<PriorityLevelList> getPriorities() async {
    try {
      final res = await _dioClient.get(Endpoints.getPriorities,options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
          'Bearer ${_sharedPreferenceHelper.authUser?.access_token ?? ''}',
        },
      ));
      return PriorityLevelList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


}