
class ChangeFavoriteModel {
  bool? status;

  String? message;


  ChangeFavoriteModel.fromJson(Map<String, dynamic> json) {
    this.status = json['status'];
    this.message = json['message'];

  }
}


