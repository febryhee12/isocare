class UserModel {
  String? memberId;
  String? memberName;
  String? isoMemberId;
  String? companyId;
  String? birthDate;
  String? gender;
  String? effectiveDate;
  String? endPolicyDate;

  UserModel({
    this.memberId,
    this.memberName,
    this.isoMemberId,
    this.companyId,
    this.birthDate,
    this.gender,
    this.effectiveDate,
    this.endPolicyDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        memberId: json['IsoMedikMemberId'],
        memberName: json['MemberName'],
        isoMemberId: json['MemberId'],
        companyId: json['BranchCode'],
        birthDate: json['DateOfBirth'],
        gender: json['Gender'],
        effectiveDate: json['EffectiveDate'],
        endPolicyDate: json['EndPolicyDate'],
      );

  static convertGender(string) {
    return (string == 'M') ? 'Laki-laki' : 'Perempuan';
  }

  static convertRelationship(string) {
    if (string == 'W') {
      return 'Istri';
    } else if (string == 'H') {
      return 'Suami';
    } else if (string == 'S') {
      return 'Anak Laki-laki';
    } else if (string == 'D') {
      return 'Anak Perempuan';
    } else {
      return '-';
    }
  }
}

// user
class User {
  User({
    this.id,
    required this.name,
    required this.username,
    required this.bpjsNumber,
    required this.insuranceNumber,
    this.email,
    this.phone,
    this.address,
    this.emailVerifiedAt,
    this.profileImage,
    this.level,
    this.status,
    this.type,
    this.yesdokRegistration,
    this.isOnline,
    required this.profileImageLink,
    required this.birthday,
    this.member,
    this.consultationType,
  });

  int? id;
  String name = '';
  String username = '';
  String bpjsNumber = '';
  String insuranceNumber = '';
  dynamic email;
  dynamic phone = '';
  late dynamic address = '';
  dynamic emailVerifiedAt;
  dynamic profileImage;
  String? level = '';
  int? status = 0;
  int? isOnline = 0;
  String profileImageLink = '';
  String birthday = '';
  String? type;
  int? yesdokRegistration = 0;
  String? consultationType;
  MemberModel? member;

  User.fromJson(Map<String, dynamic> json) {
    id = json['data']['id'] ?? 0;
    name = json['data']['name'] ?? "";
    username = json['data']['username'] ?? "";
    bpjsNumber = json['data']['bpjs_number'] ?? "";
    insuranceNumber = json['data']['insurance_number'] ?? "";
    email = json['data']['email'] ?? "";
    phone = json['data']['phone'] ?? "";
    address = json['data']['address'] ?? "";
    emailVerifiedAt = json['data']['email_verified_at'] ?? "";
    profileImage = json['data']['profile_image'];
    level = json['data']['level'] ?? "";
    status = json['data']['status'] ?? 0;
    isOnline = json['data']['is_online'] ?? 0;
    profileImageLink = json['data']['profile_image_link'] ?? "";
    birthday = json['data']["birthday"] ?? DateTime.now().toString();
    type = json['data']["type"] ?? '';
    yesdokRegistration = json['data']['yesdok_registration'];
    consultationType = json['data']['consultation_type'];
    member =
        json['member'] != null ? MemberModel.fromJson(json['member']) : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        'bpjs_number': bpjsNumber,
        "insurance_number": insuranceNumber,
        "birthday": birthday,
        "type": type,
        "email": email,
        "phone": phone,
        "address": address,
        "email_verified_at": emailVerifiedAt,
        "profile_image": profileImage,
        'yesdok_registration': yesdokRegistration,
        "level": level,
        "status": status,
        "is_online": isOnline,
        "profile_image_link": profileImageLink,
        "consultation_type": consultationType,
        "member": member!.toJson(),
      };
}

class MemberModel {
  late int? id;
  late int? userId;
  String? bpjsNumber;
  dynamic bpjsImage;
  int? bpjsVerified = 0;
  String? ktpNumber;
  dynamic ktpImage;
  int? ktpVerified = 0;
  String? insuranceNumber;
  dynamic insuranceImage;
  int? insuranceVerified = 0;
  String type = '';
  String? source = '';
  late String ktpImageLink = '';
  dynamic bpjsImageLink;
  dynamic insuranceImageLink;
  String? birthday;

  MemberModel({
    this.id,
    this.userId,
    this.bpjsNumber,
    this.bpjsImage,
    this.bpjsVerified,
    this.ktpNumber,
    this.ktpImage,
    this.ktpVerified,
    this.insuranceNumber,
    this.insuranceImage,
    this.insuranceVerified,
    required this.type,
    this.source,
    required this.ktpImageLink,
    this.bpjsImageLink,
    this.insuranceImageLink,
    this.birthday,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bpjsNumber = json['bpjs_number'];
    bpjsImage = json['bpjs_image'];
    bpjsVerified = json['bpjs_verified'] ?? 0;
    ktpNumber = json['ktp_number'];
    ktpImage = json['ktp_image'];
    ktpVerified = json['ktp_verified'] ?? 0;
    insuranceNumber = json['insurance_number'];
    insuranceImage = json['insurance_image'];
    insuranceVerified = json['insurance_verified'] ?? 0;
    type = json['type'] ?? '';
    source = json['source'] ?? '';
    ktpImageLink = json['ktp_image_link'];
    bpjsImageLink = json['bpjs_image_link'];
    insuranceImageLink = json['insurance_image_link'];
    birthday = json["birthday"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'bpjs_number': bpjsNumber,
        'bpjs_image': bpjsImage,
        'bpjs_verified': bpjsVerified,
        'ktp_number': ktpNumber,
        'ktp_image': ktpImage,
        'ktp_verified': ktpVerified,
        'insurance_number': insuranceNumber,
        'insurance_image': insuranceImage,
        'insurance_verified': insuranceVerified,
        'type': type,
        'source': source,
        'ktp_image_link': ktpImageLink,
        'bpjs_image_link': bpjsImageLink,
        'insurance_image_link': insuranceImageLink,
      };
}
