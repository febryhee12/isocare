class FamilyModel {
  int? id;
  int? userId;
  String bpjsNumber = '';
  // Null? bpjsImage;
  int? bpjsVerified;
  // Null? ktpNumber;
  // Null? ktpImage;
  String faskesName = '';
  int? ktpVerified;
  String insuranceNumber = '';
  // Null? insuranceImage;
  int? insuranceVerified;
  String? gender;
  late String insuranceCardUrlFront;
  late String insuranceCardUrlBack;
  // Null? regDate;
  String birthday = '';
  // Null? type;
  String? source;
  // Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? externalId;
  String? parentId;
  // Null? ktpImageLink;
  // Null? bpjsImageLink;
  // Null? insuranceImageLink;
  String? memberProfileImageLink;
  String memberName = '';
  // Null? memberUsername;
  // Null? memberSendbirdUserId;
  // Null? memberPrimaryAddress;

  FamilyModel({
    this.id,
    this.userId,
    required this.bpjsNumber,
    // this.bpjsImage,
    this.bpjsVerified,
    // this.ktpNumber,
    // this.ktpImage,
    required this.faskesName,
    this.ktpVerified,
    required this.insuranceNumber,
    // this.insuranceImage,

    this.insuranceVerified,
    this.gender,
    required this.insuranceCardUrlFront,
    required this.insuranceCardUrlBack,
    // this.regDate,
    required this.birthday,
    // this.type,
    this.source,
    // this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.externalId,
    this.parentId,
    // this.ktpImageLink,
    // this.bpjsImageLink,
    // this.insuranceImageLink,
    this.memberProfileImageLink,
    required this.memberName,
    // this.memberUsername,
    // this.memberSendbirdUserId,
    // this.memberPrimaryAddress
  });

  FamilyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    bpjsNumber = json['bpjs_number'] ?? "";
    // bpjsImage = json['bpjs_image'];
    bpjsVerified = json['bpjs_verified'];
    // ktpNumber = json['ktp_number'];
    // ktpImage = json['ktp_image'];
    faskesName = json['faskes_name'] ?? "";
    ktpVerified = json['ktp_verified'];
    insuranceNumber = json['insurance_number'] ?? "";
    // insuranceImage = json['insurance_image'];
    insuranceVerified = json['insurance_verified'];
    gender = json['gender'];
    insuranceCardUrlFront = json['insurance_card_url_front'];
    insuranceCardUrlBack = json['insurance_card_url_back'];
    // regDate = json['reg_date'];
    birthday = json['birthday'] ?? "";
    // type = json['type'];
    source = json['source'];
    // deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    externalId = json['external_id'];
    parentId = json['parent_id'];
    // ktpImageLink = json['ktp_image_link'];
    // bpjsImageLink = json['bpjs_image_link'];
    // insuranceImageLink = json['insurance_image_link'];
    memberProfileImageLink = json['member_profile_image_link'];
    memberName = json['member_name'];
    // memberUsername = json['member_username'];
    // memberSendbirdUserId = json['member_sendbird_user_id'];
    // memberPrimaryAddress = json['member_primary_address'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bpjs_number": bpjsNumber,
        // "bpjs_image": bpjsImage,
        "bpjs_verified": bpjsVerified,
        // "ktp_number": ktpNumber,
        // "ktp_image": ktpImage,
        "faskes_name": faskesName,
        "ktp_verified": ktpVerified,
        "insurance_number": insuranceNumber,
        // "insurance_image": insuranceImage,
        "insurance_verified": insuranceVerified,
        "gender": gender,
        "insurance_card_url_front": insuranceCardUrlFront,
        "insurance_card_url_back": insuranceCardUrlBack,
        // "reg_date": regDate,
        "birthday": birthday,
        // "type": type,
        "source": source,
        // "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "external_id": externalId,
        "parent_id": parentId,
        // "ktp_image_link": ktpImageLink,
        // "bpjs_image_link": bpjsImageLink,
        // "insurance_image_link": insuranceImageLink,
        "member_profile_image_link": memberProfileImageLink,
        "member_name": memberName,
        // "member_username": memberUsername,
        // "member_sendbird_user_id": memberSendbirdUserId,
        // "member_primary_address": memberPrimaryAddress,
      };
}
