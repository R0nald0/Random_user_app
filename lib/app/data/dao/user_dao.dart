
class UserDao {
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

  const UserDao({
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
  });

  factory UserDao.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final street = location['street'] ?? {};
    final coordinates = location['coordinates'] ?? {};
    final timezone = location['timezone'] ?? {};
    final login = json['login'] ?? {};
    final dob = json['dob'] ?? {};
    final registered = json['registered'] ?? {};
    final id = json['id'] ?? {};
    final picture = json['picture'] ?? {};

    return UserDao(
      gender: json['gender'] ?? '',
      title: json['name']?['title'] ?? '',
      firstName: json['name']?['first'] ?? '',
      lastName: json['name']?['last'] ?? '',
      streetNumber: street['number'] ?? 0,
      streetName: street['name'] ?? '',
      city: location['city'] ?? '',
      state: location['state'] ?? '',
      country: location['country'] ?? '',
      postcode: location['postcode'].toString(),
      latitude: coordinates['latitude'] ?? '',
      longitude: coordinates['longitude'] ?? '',
      timezoneOffset: timezone['offset'] ?? '',
      timezoneDescription: timezone['description'] ?? '',
      email: json['email'] ?? '',
      uuid: login['uuid'] ?? '',
      username: login['username'] ?? '',
      password: login['password'] ?? '',
      salt: login['salt'] ?? '',
      md5: login['md5'] ?? '',
      sha1: login['sha1'] ?? '',
      sha256: login['sha256'] ?? '',
      dateOfBirth: dob['date'] ?? '',
      age: dob['age'] ?? 0,
      registeredDate: registered['date'] ?? '',
      registeredAge: registered['age'] ?? 0,
      phone: json['phone'] ?? '',
      cell: json['cell'] ?? '',
      idName: id['name'] ?? '',
      idValue: id['value'] ?? '',
      pictureLarge: picture['large'] ?? '',
      pictureMedium: picture['medium'] ?? '',
      pictureThumbnail: picture['thumbnail'] ?? '',
      nat: json['nat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'streetNumber': streetNumber,
        'streetName': streetName,
        'city': city,
        'state': state,
        'country': country,
        'postcode': postcode,
        'latitude': latitude,
        'longitude': longitude,
        'timezoneOffset': timezoneOffset,
        'timezoneDescription': timezoneDescription,
        'email': email,
        'uuid': uuid,
        'username': username,
        'password': password,
        'salt': salt,
        'md5': md5,
        'sha1': sha1,
        'sha256': sha256,
        'dateOfBirth': dateOfBirth,
        'age': age,
        'registeredDate': registeredDate,
        'registeredAge': registeredAge,
        'phone': phone,
        'cell': cell,
        'idName': idName,
        'idValue': idValue,
        'pictureLarge': pictureLarge,
        'pictureMedium': pictureMedium,
        'pictureThumbnail': pictureThumbnail,
        'nat': nat,
      };
}
