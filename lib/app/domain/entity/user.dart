import 'package:flutter/material.dart';

class User {
  final int? id;
  final String gender;
  final String title;
  final String name;
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
  final List<String> pictures;
  final String nat;
  final bool isPersisted;

    User({
    required this.gender,
    required this.title,
    required this.name,
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
    required this.pictures,
    required this.nat,
    this.id,
    this.isPersisted = false
  });

  User copyWith({
    ValueGetter<int?>? id,
    String? gender,
    String? title,
    String? name,
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
    List<String>? pictures,
    String? nat    
  }) {
    return User(
          id: id != null ? id() : this.id,
      gender: gender ?? this.gender,
      title: title ?? this.title,
      name: name ?? this.name,
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
      pictures: pictures ?? this.pictures,
      nat: nat ?? this.nat
    );
  }
}
