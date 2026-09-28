import 'package:news_app/Domain/entities/source.dart';

class SourceModel extends Source {
  //step1 -->> Constructor :
  const SourceModel({
    required super.id,
    required super.name ,
    required super.url ,
    required super.country
  });

  //step2 -->> create factory constructor name fromJson :
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      url: json['url'] as String?,
      country: json['country'] as String?,
    );
  }

  //step3 -->> create function to convert to json :
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'country': country,
    };
  }


}