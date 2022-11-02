import 'package:mobile/model/ContactModel.dart';

import 'UserType.dart';

class UserModel {
  String? email;
  String? password;
  String? userType;
  String? name;
  String? lastName;
  DateTime? birthDate;
  ContactModel contact = ContactModel();
}
