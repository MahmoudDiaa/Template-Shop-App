import 'dart:convert';

import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/models/incident/incident_list.dart';
import 'package:dio/dio.dart';

import '../../../../constants/enums.dart';
import '../../../../models/category/category_list.dart';
import '../../../../models/incident/incident.dart';
import '../../../../models/incident/incident_filter.dart';
import '../../../../models/user/auth_user.dart';
import '../../../../models/user/user.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../api_response.dart';
import '../../constants/endpoints.dart';

class IncidentApi {
  final DioClient _dioClient;
  SharedPreferenceHelper sharedPreferenceHelper;
  ApiResponse? apiResponse;

  IncidentApi(
      this._dioClient, SharedPreferenceHelper this.sharedPreferenceHelper);

  /// Returns list of Incident in response
  Future<IncidentList> getIncidents(
      int pageNumber, IncidentFilter? incidentFilter) async {
    try {
      final res = await _dioClient.post(
          '${Endpoints.getIncidents}?currentPage=${pageNumber}',
          data: {
            "pageSize": 10,
            "categoryId": incidentFilter?.categoryId,
            "subCategoryId": incidentFilter?.subCategoryId,
            "distance": incidentFilter?.latlng == null
                ? null
                : {
                    "lat": incidentFilter?.latlng?.latitude,
                    "long": incidentFilter?.latlng?.longitude,
                    "distanceInMeter": incidentFilter?.distance
                  },
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      return IncidentList.fromJson(res['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool?> save(Incident incident) async {
    try {
      final res = await _dioClient.post(Endpoints.saveIncident,
          data: jsonEncode(incident.toMap()),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse?.success;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool?> saveWorkFlowStep(
      Incident incident, IncidentStatusEnum incidentStatusEnum) async {
    try {
      final res = await _dioClient.post(
          incidentStatusEnum.workflowSubmitEndpointName ?? '',
          data: jsonEncode(incident.toWorkflowMap(incidentStatusEnum)),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      apiResponse = ApiResponse.fromMap(res);
      return apiResponse?.success;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Incident> getIncident(String id) async {
    try {
      final res = await _dioClient.get('${Endpoints.getIncident}${id}',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${sharedPreferenceHelper.authUser?.access_token ?? ''}',
            },
          ));
      return Incident.fromMap(res['data']);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
