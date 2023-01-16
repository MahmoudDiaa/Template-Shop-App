import '../../constants/strings.dart';

class Priority {
  int? id;
  String? arabicName;
  String? englishName;

  Priority({
    this.id,
    this.arabicName,
    this.englishName,
  });

  String? localizedName(String language) {
    switch (language) {
      case Strings.englishCode:
        return this.englishName;
        break;
      case Strings.arabicCode:
        return this.arabicName;
        break;
    }
    return 'unknown language code';
  }

  factory Priority.fromMap(Map<String, dynamic> json) => Priority(
        id: json['id'],
        arabicName: json['arabicName'],
        englishName: json['englishName'],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['arabicName'] = this.arabicName;
    data['englishName'] = this.englishName;

    return data;
  }
}
