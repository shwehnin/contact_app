import 'package:json_annotation/json_annotation.dart';
part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final String? id;
  final String? name;
  final String? job;
  final int? age;

  ContactModel({this.id, this.name, this.job, this.age});

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
