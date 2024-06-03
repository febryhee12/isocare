class ChatGenerate {
  late bool status;
  late int code;
  late ChatModel data;
  late String message;

  ChatGenerate(
      {required this.status,
      required this.code,
      required this.data,
      required this.message});

  ChatGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = (json['data'] != null ? ChatModel.fromJson(json['data']) : null)!;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['data'] = this.data.toJson();
    data['message'] = message;
    return data;
  }
}

class ChatModel {
  late int memberId;
  dynamic status;
  late String channelUrl;
  late String endChat;
  late String doctorName;
  late String doctorProfileImageLink;
  late String memberSendbirdUserId;
  late String doctorSendbirdUserId;

  ChatModel({
    required this.memberId,
    required this.status,
    required this.channelUrl,
    required this.endChat,
    required this.doctorName,
    required this.doctorProfileImageLink,
    required this.memberSendbirdUserId,
    required this.doctorSendbirdUserId,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    memberId = json['member_Id'] ?? 0;
    status = json['status'] ?? 0;
    channelUrl = json['channel_url'] ?? '';
    endChat = json['end_chat'] ?? '';
    doctorName = json['doctor_name'] ?? '';
    doctorProfileImageLink = json['doctor_profile_image_link'] ?? '';
    memberSendbirdUserId = json['member_sendbird_user_id'] ?? '';
    doctorSendbirdUserId = json['doctor_sendbird_user_id'];
  }

  Map<String, dynamic> toJson() => {
        'member_Id': memberId,
        'channel_url': channelUrl,
        'end_chat': endChat,
        'doctor_name': doctorName,
        'status': status,
        'doctor_profile_image_link': doctorProfileImageLink,
        'member_sendbird_user_id': memberSendbirdUserId,
        'doctor_sendbird_user_id': doctorSendbirdUserId,
      };
}

class ChatModelAdmin {
  late int memberId;
  late int adminId;
  late String channelUrl;
  late String endChat;
  late String adminName;
  dynamic status;
  late String adminProfileImageLink;
  late String memberSendbirdUserId;
  late String adminSendbirdUserId;

  ChatModelAdmin({
    required this.memberId,
    required this.adminId,
    required this.channelUrl,
    required this.endChat,
    required this.adminName,
    required this.status,
    required this.adminProfileImageLink,
    required this.memberSendbirdUserId,
    required this.adminSendbirdUserId,
  });

  ChatModelAdmin.fromJson(Map<String, dynamic> json) {
    memberId = json['member_Id'] ?? 0;
    adminId = json['admin_Id'] ?? 0;
    channelUrl = json['channel_url'] ?? '';
    endChat = json['end_chat'] ?? '';
    adminName = json['admin_name'] ?? '';
    status = json['status'] ?? 0;
    adminProfileImageLink = json['admin_profile_image_link'] ?? '';
    memberSendbirdUserId = json['member_sendbird_user_id'] ?? '';
    adminSendbirdUserId = json['admin_sendbird_user_id'];
  }

  Map<String, dynamic> toJson() => {
        'member_Id': memberId,
        'admin_Id': adminId,
        'channel_url': channelUrl,
        'end_chat': endChat,
        'doctor_name': adminName,
        'status': status,
        'doctor_profile_image_link': adminProfileImageLink,
        'member_sendbird_user_id': memberSendbirdUserId,
        'doctor_sendbird_user_id': adminSendbirdUserId,
      };
}
