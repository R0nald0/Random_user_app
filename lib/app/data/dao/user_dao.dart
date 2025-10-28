import 'package:flutter/widgets.dart';

import 'package:random_user_bus_2_teste/app/domain/entity/user.dart';

class UserDao {
  final int? id;
  final String gender;
  final String title;
  final String firstName;
  final String lastName;
  final int streetNumber;
  final String streetName;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final String latitude;
  final String longitude;
  final String timezoneOffset;
  final String timezoneDescription;
  final String email;
  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;
  final String dateOfBirth;
  final int age;
  final String registeredDate;
  final int registeredAge;
  final String phone;
  final String cell;
  final String idName;
  final String idValue;
  final String pictureLarge;
  final String pictureMedium;
  final String pictureThumbnail;
  final String nat;
  final bool isPersisted;
  

  UserDao({
    this.id,
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.streetNumber,
    required this.streetName,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.latitude,
    required this.longitude,
    required this.timezoneOffset,
    required this.timezoneDescription,
    required this.email,
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
    required this.dateOfBirth,
    required this.age,
    required this.registeredDate,
    required this.registeredAge,
    required this.phone,
    required this.cell,
    required this.idName,
    required this.idValue,
    required this.pictureLarge,
    required this.pictureMedium,
    required this.pictureThumbnail,
    required this.nat,
    this.isPersisted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gender': gender,
      'title': title,
      'first_name': firstName,
      'last_name': lastName,
      'street_number': streetNumber,
      'street_name': streetName,
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'latitude': latitude,
      'longitude': longitude,
      'timezone_offset': timezoneOffset,
      'timezone_description': timezoneDescription,
      'email': email,
      'uuid': uuid,
      'username': username,
      'password': password,
      'salt': salt,
      'md5': md5,
      'sha1': sha1,
      'sha256': sha256,
      'date_of_birth': dateOfBirth,
      'age': age,
      'registered_date': registeredDate,
      'registered_age': registeredAge,
      'phone': phone,
      'cell': cell,
      'id_name': idName,
      'id_value': idValue,
      'picture_large': pictureLarge,
      'picture_medium': pictureMedium,
      'picture_thumbnail': pictureThumbnail,
      'nat': nat,
      'is_persisted': isPersisted ? 1 : 0,
    };
  }

  factory UserDao.fromMap(Map<String, dynamic> map) {
    return UserDao(
      id: map['id'] as int?,
      gender: map['gender'] ?? '',
      title: map['title'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      streetNumber: map['street_number'] ?? 0,
      streetName: map['street_name'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      postcode: map['postcode'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      timezoneOffset: map['timezone_offset'] ?? '',
      timezoneDescription: map['timezone_description'] ?? '',
      email: map['email'] ?? '',
      uuid: map['uuid'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      salt: map['salt'] ?? '',
      md5: map['md5'] ?? '',
      sha1: map['sha1'] ?? '',
      sha256: map['sha256'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      age: map['age'] ?? 0,
      registeredDate: map['registered_date'] ?? '',
      registeredAge: map['registered_age'] ?? 0,
      phone: map['phone'] ?? '',
      cell: map['cell'] ?? '',
      idName: map['id_name'] ?? '',
      idValue: map['id_value'] ?? '',
      pictureLarge: map['picture_large'] ?? '',
      pictureMedium: map['picture_medium'] ?? '',
      pictureThumbnail: map['picture_thumbnail'] ?? '',
      nat: map['nat'] ?? '',
      isPersisted: (map['is_persisted'] ?? 0) == 1,
    );
  }


  User toDomain() {
    return User(
      id: id,
      isPersisted: isPersisted,
      gender: gender,
      title: title,
      name: "$firstName $lastName".trim(),
      streetNumber: streetNumber,
      streetName: streetName,
      city: city,
      state: state,
      country: country,
      postcode: postcode,
      latitude: latitude,
      longitude: longitude,
      timezoneOffset: timezoneOffset,
      timezoneDescription: timezoneDescription,
      email: email,
      uuid: uuid,
      username: username,
      password: password,
      salt: salt,
      md5: md5,
      sha1: sha1,
      sha256: sha256,
      dateOfBirth: dateOfBirth,
      age: age,
      registeredDate: registeredDate,
      registeredAge: registeredAge,
      phone: phone,
      cell: cell,
      idName: idName,
      idValue: idValue,
      pictures: [pictureLarge, pictureMedium, pictureThumbnail],
      nat: nat,
    );
  }


  factory UserDao.fromDomain(User user, {bool isPersisted = false}) {
    // Divide o campo "name" em firstName e lastName
    final nameParts = user.name.trim().split(' ');
    final first = nameParts.isNotEmpty ? nameParts.first : '';
    final last = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return UserDao(
      gender: user.gender,
      title: user.title,
      firstName: first,
      lastName: last,
      streetNumber: user.streetNumber,
      streetName: user.streetName,
      city: user.city,
      state: user.state,
      country: user.country,
      postcode: user.postcode,
      latitude: user.latitude,
      longitude: user.longitude,
      timezoneOffset: user.timezoneOffset,
      timezoneDescription: user.timezoneDescription,
      email: user.email,
      uuid: user.uuid,
      username: user.username,
      password: user.password,
      salt: user.salt,
      md5: user.md5,
      sha1: user.sha1,
      sha256: user.sha256,
      dateOfBirth: user.dateOfBirth,
      age: user.age,
      registeredDate: user.registeredDate,
      registeredAge: user.registeredAge,
      phone: user.phone,
      cell: user.cell,
      idName: user.idName,
      idValue: user.idValue,
      pictureLarge: user.pictures.isNotEmpty ? user.pictures[0] : '',
      pictureMedium: user.pictures.length > 1 ? user.pictures[1] : '',
      pictureThumbnail: user.pictures.length > 2 ? user.pictures[2] : '',
      nat: user.nat,
      isPersisted: isPersisted,
    );
  }

  UserDao copyWith({
    ValueGetter<int?>? id,
    String? gender,
    String? title,
    String? firstName,
    String? lastName,
    int? streetNumber,
    String? streetName,
    String? city,
    String? state,
    String? country,
    String? postcode,
    String? latitude,
    String? longitude,
    String? timezoneOffset,
    String? timezoneDescription,
    String? email,
    String? uuid,
    String? username,
    String? password,
    String? salt,
    String? md5,
    String? sha1,
    String? sha256,
    String? dateOfBirth,
    int? age,
    String? registeredDate,
    int? registeredAge,
    String? phone,
    String? cell,
    String? idName,
    String? idValue,
    String? pictureLarge,
    String? pictureMedium,
    String? pictureThumbnail,
    String? nat,
    bool? isPersisted,
  }) {
    return UserDao(
      id: id != null ? id() : this.id,
      gender: gender ?? this.gender,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      streetNumber: streetNumber ?? this.streetNumber,
      streetName: streetName ?? this.streetName,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      timezoneDescription: timezoneDescription ?? this.timezoneDescription,
      email: email ?? this.email,
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      password: password ?? this.password,
      salt: salt ?? this.salt,
      md5: md5 ?? this.md5,
      sha1: sha1 ?? this.sha1,
      sha256: sha256 ?? this.sha256,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      registeredDate: registeredDate ?? this.registeredDate,
      registeredAge: registeredAge ?? this.registeredAge,
      phone: phone ?? this.phone,
      cell: cell ?? this.cell,
      idName: idName ?? this.idName,
      idValue: idValue ?? this.idValue,
      pictureLarge: pictureLarge ?? this.pictureLarge,
      pictureMedium: pictureMedium ?? this.pictureMedium,
      pictureThumbnail: pictureThumbnail ?? this.pictureThumbnail,
      nat: nat ?? this.nat,
      isPersisted: isPersisted ?? this.isPersisted,
    );
  }
}
