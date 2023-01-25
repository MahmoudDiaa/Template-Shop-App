class PriorityLevel {
  PriorityLevel({
      this.id, 
      this.arabicName, 
      this.englishName, 
      this.colorCode,});

  PriorityLevel.fromJson(dynamic json) {
    id = json['id'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    colorCode = json['colorCode'];
  }
  int? id;
  String? arabicName;
  String? englishName;
  String? colorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['arabicName'] = arabicName;
    map['englishName'] = englishName;
    map['colorCode'] = colorCode;
    return map;
  }

}