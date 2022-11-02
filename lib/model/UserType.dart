enum UserType { organization, doctor, patient }

extension UserTypeExtension on UserType {
  String get name {
    switch (this) {
      case UserType.organization:
        return 'ORGANIZATION';
      case UserType.doctor:
        return 'DOCTOR';
      case UserType.patient:
        return 'PATIENT';
    }
  }
}
