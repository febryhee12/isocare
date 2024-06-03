class ListDoctor {
  late int id;
  late String name;
  late String username;
  late String email;
  late String phone;
  late String address;
  late String level;
  late int status;
  late int isOnline;
  late String profileImageLink;
  List<Doctor>? doctor;

  ListDoctor(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.address,
      required this.level,
      required this.status,
      required this.isOnline,
      required this.profileImageLink,
      this.doctor});

  ListDoctor.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    username = json['username'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'] ?? "";
    level = json['level'] ?? "";
    status = json['status'] ?? 0;
    isOnline = json['is_online'] ?? 0;
    profileImageLink = json['profile_image_link'] ?? "";
    // if (json['doctor'] != null) {
    //   doctor = <Doctor>[];
    //   json['doctor'].forEach((v) {
    //     doctor!.add(new Doctor.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['level'] = level;
    data['status'] = status;
    data['is_online'] = isOnline;
    data['profile_image_link'] = profileImageLink;
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  late int id;
  late String name;
  late Pivot? pivot;

  Doctor({required this.id, required this.name, this.pivot});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  late int userId;
  late int doctorSpecializationId;

  Pivot({required this.userId, required this.doctorSpecializationId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    doctorSpecializationId = json['doctor_specialization_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['doctor_specialization_id'] = doctorSpecializationId;
    return data;
  }
}
