
import 'package:json_annotation/json_annotation.dart';
import 'package:multiple_accounts/models/user/user_model.dart';

part 'accounts_model.g.dart';

@JsonSerializable()
class AccountsModel {
  final String account_id;
  final UserModel mainUser;
  final List<UserModel> subUsers;
 

  AccountsModel({required this.account_id, required this.mainUser, required this.subUsers});

  factory AccountsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsModelToJson(this);
}