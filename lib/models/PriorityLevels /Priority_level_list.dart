import 'priorrity_level.dart';

class PriorityLevelList {
  PriorityLevelList({
      this.success, 
      this.pagesCount, 
      this.priorities,
      this.message, 
      this.info,});

  PriorityLevelList.fromJson(dynamic json) {
    success = json['success'];
    pagesCount = json['pagesCount'];
    if (json['data'] != null) {
      priorities = [];
      json['data'].forEach((v) {
        priorities?.add(PriorityLevel.fromJson(v));
      });
    }
    message = json['message'];
    info = json['info'];
  }
  bool? success;
  int? pagesCount;
  List<PriorityLevel>? priorities;
  String? message;
  dynamic info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['pagesCount'] = pagesCount;
    if (priorities != null) {
      map['data'] = priorities?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['info'] = info;
    return map;
  }

}