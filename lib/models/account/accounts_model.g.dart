// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsModel _$AccountsModelFromJson(Map<String, dynamic> json) =>
    AccountsModel(
      account_id: json['account_id'] as String,
      mainUser: UserModel.fromJson(json['mainUser'] as Map<String, dynamic>),
      subUsers: (json['subUsers'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountsModelToJson(AccountsModel instance) =>
    <String, dynamic>{
      'account_id': instance.account_id,
      'mainUser': instance.mainUser,
      'subUsers': instance.subUsers,
    };
