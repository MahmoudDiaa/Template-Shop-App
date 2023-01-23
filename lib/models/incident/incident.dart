import 'dart:io';

import 'package:boilerplate/models/incident/transaction/incident_transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import 'incident_image.dart';
import 'dart:convert';

class Incident {
  int? categoryId;
  PickResult? mapPlace;
  List<IncidentImage> images = [];

  List<XFile> xFiles = [];

  List<IncidentTransaction> transactions = [];

  IncidentImage? get primaryImageFromList {
    if (images == null || images.length == 0) return null;
    return images.firstWhere((element) => element.isPrimary == true);
  }

  double? amountValue;
  int? subCategoryId;
  int? amountUnitId;
  String? amountUnitName;

  String? get primaryImageUrl {
    return null;
  }

  String? localizedCategoryName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.incidentCategoryEnglishName;
        break;
      case Strings.arabicCode:
        return this.incidentCategoryArabicName;
        break;
    }
    return 'unknown language code';
  }

  String? localizedSubCategoryName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.incidentSubCategoryEnglishName;
        break;
      case Strings.arabicCode:
        return this.incidentSubCategoryArabicName;
        break;
    }
    return 'unknown language code';
  }

  String? localizedStatusName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.incidentStatusEnglishName;
        break;
      case Strings.arabicCode:
        return this.incidentStatusArabicName;
        break;
    }
    return 'unknown language code';
  }

  String? localizedPriorityName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.priorityTextEnglish;
        break;
      case Strings.arabicCode:
        return this.priorityTextArabic;
        break;
    }
    return 'unknown language code';
  }

  // String? get title {
  //   if (this.id == null) return null;
  //   return '${this.incidentCategoryArabicName == null ? '' : this.incidentCategoryArabicName}-'
  //       '${this.incidentSubCategoryArabicName == null ? '' : this.incidentSubCategoryArabicName} ('
  //       '${this.id == null ? '' : this.id?.substring(0, 3)})';
  // }
  String? localizedTitle(String language) {
    if (this.id == null) return null;
    return '${this.localizedCategoryName(language) ?? ''}-'
        '${this.localizedSubCategoryName(language) ?? ''} ('
        '${this.id == null ? '' : this.id?.substring(0, 3)})';
  }

  String? id;
  String? lat;
  String? long;
  String? notes;
  DateTime? createDate;
  String? createHijriDate;
  String? createTime;
  String? incidentStatusArabicName;
  String? incidentStatusEnglishName;
  String? incidentStatusColor;
  String? incidentUnitArabicName;
  String? incidentUnitEnglishName;
  double? unitValue;
  String? districtName;
  String? streetName;
  String? address;
  String? incidentCategoryArabicName;
  String? incidentCategoryEnglishName;
  String? incidentSubCategoryArabicName;
  String? incidentSubCategoryEnglishName;
  bool? isNew;
  String? userFullName;
  int? imagesCount;
  int? transactonCount;
  int? priority;
  String? priorityTextArabic;
  String? priorityTextEnglish;
  int? incidentStatusId;

  Incident({
    this.id,
    this.lat,
    this.long,
    this.notes,
    this.createDate,
    this.createHijriDate,
    this.createTime,
    this.incidentStatusArabicName,
    this.incidentStatusEnglishName,
    this.incidentStatusColor,
    this.incidentUnitArabicName,
    this.incidentUnitEnglishName,
    this.unitValue,
    this.districtName,
    this.streetName,
    this.address,
    this.incidentCategoryArabicName,
    this.incidentCategoryEnglishName,
    this.incidentSubCategoryArabicName,
    this.incidentSubCategoryEnglishName,
    this.isNew,
    this.userFullName,
    this.imagesCount,
    this.transactonCount,
    this.priority,
    this.incidentStatusId,
  });

  MaterialColor? get StatusColorDart {
    switch (this.incidentStatusColor) {
      case 'orange':
        return Colors.orange;
        break;
      case 'blue':
        return Colors.blue;
        break;
      case 'green':
        return Colors.green;
        break;
      case 'yellow':
        return Colors.yellow;
        break;
    }
    return null;
  }

  BitmapDescriptor get markerIcon {
    switch (this.status) {
      case IncidentStatusEnum.New:
        return BitmapDescriptor.defaultMarkerWithHue(100);
      case IncidentStatusEnum.Assigned:
        return BitmapDescriptor.defaultMarkerWithHue(200);
      case IncidentStatusEnum.Solved:
        return BitmapDescriptor.defaultMarkerWithHue(300);
      case IncidentStatusEnum.Upped:
        return BitmapDescriptor.defaultMarkerWithHue(350);
      case IncidentStatusEnum.SolvedInitially:
        return BitmapDescriptor.defaultMarkerWithHue(310);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  // bool get IsStatusAssigned {
  //   return this.incidentStatusId == IncidentStatusEnum.Assigned.id;
  // }
  //
  // bool get IsStatusSolvedInitially {
  //   return this.incidentStatusId == IncidentStatusEnum.SolvedInitially.id;
  // }

  getPriorityText(priority, lan) {
    switch (priority) {
      case 1:
        return lan == 'ar' ? 'منخفضة' : 'Low';

        break;
      case 2:
        return lan == 'ar' ? 'متوسط' : 'Medium';

        break;
      case 3:
        return lan == 'ar' ? 'عالي' : 'High';

        break;
      default:
        return lan == 'ar' ? 'غير محدد' : 'Unknown';
        break;
    }
  }

  Incident.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
    notes = json['notes'];
    createDate =
        json['createDate'] == null ? null : DateTime.parse(json['createDate']);
    createHijriDate = json['createHijriDate'];
    createTime = json['createTime'];
    incidentStatusArabicName = json['incidentStatusArabicName'];
    incidentStatusEnglishName = json['incidentStatusEnglishName'];
    incidentStatusColor = json['incidentStatusColor'];
    incidentUnitArabicName = json['incidentUnitArabicName'];
    incidentUnitEnglishName = json['incidentUnitEnglishName'];
    unitValue = json['unitValue'] == null ? null : json['unitValue'];
    districtName = json['districtName'];
    streetName = json['streetName'];
    address = json['address'];
    incidentCategoryArabicName = json['incidentCategoryArabicName'];
    incidentCategoryEnglishName = json['incidentCategoryEnglishName'];
    incidentSubCategoryArabicName = json['incidentSubCategoryArabicName'];
    incidentSubCategoryEnglishName = json['incidentSubCategoryEnglishName'];
    isNew = json['isNew'];
    userFullName = json['userFullName'];
    imagesCount = json['imagesCount'];
    transactonCount = json['transactonCount'];
    priority = json['priority'];
    priorityTextArabic = getPriorityText(json['priority'], 'ar');
    priorityTextEnglish = getPriorityText(json['priority'], 'en');
    incidentStatusId = json['incidentStatusId'];

    if (json['images'] != null) {
      // Map<String, dynamic> myMap = json['images'];
      // images = myMap.map((e) => IncidentImage.fromJson(e)).toList();
      // List<dynamic> entitlements = myMap["Dependents"][0]["Entitlements"];
      images = (json['images'] as List)
          .map((e) => IncidentImage.fromJson(e))
          .toList();
    }
    transactions = json['transactions'] == null
        ? []
        : (json['transactions'] as List<dynamic>)
            .map((e) => IncidentTransaction.fromMap(e))
            .toList();
  }

  Map<String, dynamic> toMap() {
    var images = [];
    if (xFiles != null) {
      xFiles.forEach((element) {
        images.add({
          'ImageBase64': "data:image/png;base64," +
              base64Encode(File(element.path).readAsBytesSync()),
          'isPrimary': false
        });
      });
    }
    if (images.length > 0) images[0]['isPrimary'] = true;

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['SubCategoryId'] = this.subCategoryId;
    data['IsImagesBase64'] = true;
    data['lat'] = this.mapPlace?.geometry?.location.lat.toString()??"27.503035";
    data['long'] = this.mapPlace?.geometry?.location.lng.toString()??"41.709509";
    data['districtName'] = mapPlace?.addressComponents?[1].longName;
    data['streetName'] = mapPlace?.addressComponents?[0].longName;
    data['address'] = mapPlace?.addressComponents == null
        ? null
        : mapPlace?.addressComponents?.map((e) => e.longName)?.toString();
    data['AmountUnitId'] = this.amountUnitId;
    data['UnitValue'] = this.amountValue;
    data['notes'] = this.notes;
    data['Images'] = images;
    data['priority'] = priority;
    data['incidentStatusId'] = incidentStatusId;

    // data['id'] = this.id;

    // data['createDate'] = this.createDate;
    // data['createHijriDate'] = this.createHijriDate;
    // data['createTime'] = this.createTime;
    // data['incidentStatusArabicName'] = this.incidentStatusArabicName;
    // data['incidentStatusEnglishName'] = this.incidentStatusEnglishName;
    // data['incidentStatusColor'] = this.incidentStatusColor;
    // data['incidentUnitArabicName'] = this.incidentUnitArabicName;
    // data['incidentUnitEnglishName'] = this.incidentUnitEnglishName;
    // data['unitValue'] = this.unitValue;
    // data['incidentCategoryArabicName'] = this.incidentCategoryArabicName;
    // data['incidentCategoryEnglishName'] = this.incidentCategoryEnglishName;
    // data['incidentSubCategoryArabicName'] = this.incidentSubCategoryArabicName;
    // data['incidentSubCategoryEnglishName'] =
    //     this.incidentSubCategoryEnglishName;
    // data['isNew'] = this.isNew;
    // data['userFullName'] = this.userFullName;
    // data['imagesCount'] = this.imagesCount;
    // data['transactonCount'] = this.transactonCount;
    return data;
  }

  Map<String, dynamic> toWorkflowMap(IncidentStatusEnum incidentStatus) {
    var images = [];

    xFiles.forEach((element) {
      images.add({
        // 'ImageBase64': "data:image/png;base64," +
        //     base64Encode(File(element.path).readAsBytesSync()),
        'ImageBase64':
            "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=",
        'isPrimary': false
      });
    });

    if (images.length > 0) images[0]['isPrimary'] = true;

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsImagesBase64'] = true;
    data['lat'] = this.mapPlace?.geometry?.location?.lat?.toString();
    data['long'] = this.mapPlace?.geometry?.location?.lng?.toString();
    data['notes'] = this.notes;
    data['Images'] = images;
    data['IncidentID'] = this.id;
    data['status'] = incidentStatus.id;
    return data;
  }

  IncidentStatusEnum get status {
    switch (incidentStatusId) {
      case 1:
        return IncidentStatusEnum.New;
      case 2:
        return IncidentStatusEnum.Assigned;
      case 3:
        return IncidentStatusEnum.Solved;
      case 4:
        return IncidentStatusEnum.Upped;
      case 5:
        return IncidentStatusEnum.SolvedInitially;
      default:
        return IncidentStatusEnum.Unkown;
    }
  }
}
