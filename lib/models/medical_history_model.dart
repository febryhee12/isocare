class MedicalHistoryModel {
  late int id;
  late int doctorId;
  late int memberId;
  late String prediagnostic;
  late String symptom;
  late String firstAid;
  late String physicalCheck;
  late String labResult;
  late String checkupDate;
  late String memberName;
  late String doctorName;
  late String labFile;
  late String doctorProfileImageLink;
  late String medicineRecipeTrackingStatus;
  late List<MedicineRecipes>? medicineRecipes;
  late List<MedicineRecipeTracking>? medicineRecipeTracking;

  MedicalHistoryModel(
      {required this.id,
      required this.doctorId,
      required this.memberId,
      required this.prediagnostic,
      required this.symptom,
      required this.firstAid,
      required this.physicalCheck,
      required this.labResult,
      required this.checkupDate,
      required this.memberName,
      required this.doctorName,
      required this.labFile,
      required this.doctorProfileImageLink,
      required this.medicineRecipeTrackingStatus,
      this.medicineRecipes,
      this.medicineRecipeTracking});

  MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    doctorId = json['doctor_id'] ?? 0;
    memberId = json['member_id'] ?? 0;
    prediagnostic = json['prediagnostic'] ?? "";
    symptom = json['symptom'] ?? "";
    firstAid = json['first_aid'] ?? "";
    physicalCheck = json['physical_check'] ?? "";
    labResult = json['lab_result'] ?? "";
    checkupDate = json['checkup_date'] ?? "";
    memberName = json['member_name'] ?? "";
    doctorName = json['doctor_name'] ?? "";
    labFile = json['lab_file'] ?? "";
    doctorProfileImageLink = json['doctor_profile_image_link'] ?? "";
    medicineRecipeTrackingStatus =
        json['medicine_recipe_tracking_status'] ?? "";
    medicineRecipes = [];
    json['medicine_recipes'].forEach((x) {
      medicineRecipes!.add(MedicineRecipes.fromJson(x));
    });
    medicineRecipeTracking = [];
    json['medicine_recipe_tracking'].forEach((x) {
      medicineRecipeTracking!.add(MedicineRecipeTracking.fromJson(x));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['member_id'] = memberId;
    data['prediagnostic'] = prediagnostic;
    data['symptom'] = symptom;
    data['first_aid'] = firstAid;
    data['physical_check'] = physicalCheck;
    data['lab_result'] = labResult;
    data['checkup_date'] = checkupDate;
    data['member_name'] = memberName;
    data['doctor_name'] = doctorName;
    data['lab_file'] = labFile;
    data['doctor_profile_image_link'] = doctorProfileImageLink;
    data['medicine_recipe_tracking_status'] = medicineRecipeTrackingStatus;
    data['medicine_recipes'] = medicineRecipes!.map((v) => v.toJson()).toList();
    data['medicine_recipe_tracking'] =
        medicineRecipeTracking!.map((v) => v.toJson()).toList();
    return data;
  }
}

class MedicineRecipes {
  late int? id;
  late int? medicalHistoryId;
  late String medicineName;
  late String unit;
  late int quantity;
  late String direction;

  MedicineRecipes({
    this.id,
    this.medicalHistoryId,
    required this.medicineName,
    required this.unit,
    required this.quantity,
    required this.direction,
  });

  MedicineRecipes.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    medicalHistoryId = json['medical_history_id'] ?? 0;
    medicineName = json['medicine_name'] ?? '';
    unit = json['unit'] ?? '';
    quantity = json['quantity'] ?? 0;
    direction = json['direction'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['medical_history_id'] = medicalHistoryId;
    data['medicine_name'] = medicineName;
    data['unit'] = unit;
    data['quantity'] = quantity;
    data['direction'] = direction;
    return data;
  }
}

class MedicineRecipeTracking {
  late int? id;
  late int? medicalHistoryId;
  late String description;
  late String type;
  late String status;
  late String createdAt;

  MedicineRecipeTracking({
    this.id,
    this.medicalHistoryId,
    required this.description,
    required this.type,
    required this.status,
    required this.createdAt,
  });

  MedicineRecipeTracking.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    medicalHistoryId = json['medical_history_id'] ?? 0;
    description = json['description'] ?? '';
    type = json['type'] ?? '';
    status = json['status'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['medical_history_id'] = medicalHistoryId;
    data['description'] = description;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
