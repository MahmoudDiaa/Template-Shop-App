import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class IncidentFilter {
  int? categoryId;

  int? subCategoryId;
  String? incidentId;

  LatLng? latlng;
  double distance;

  IncidentFilter(
      {this.subCategoryId,
      this.categoryId,
      this.incidentId,
      this.latlng,
      this.distance = 1000});
}
