import 'package:boilerplate/extension/string_extension.dart';

class IncidentImage {
  String? imageUrl;
  int? type;
  bool? isPrimary;

  IncidentImage({this.imageUrl, this.type, this.isPrimary});

  factory IncidentImage.fromJson(Map<String, dynamic> json) => IncidentImage(
      imageUrl: json['path'], type: json['type'], isPrimary: json['isPrimary']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.imageUrl;
    data['type'] = this.type;
    data['isPrimary'] = this.isPrimary;
    return data;
  }

  String? get UrlAfterCheckUrl {
    if (this.imageUrl == null) return null;
    if (this.imageUrl.isValidUrl())
      return this.imageUrl;
    else
      return 'http://51.15.23.9:8085/Uploads/Incidents/${this.imageUrl}';
  }
}
