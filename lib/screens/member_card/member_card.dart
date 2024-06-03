import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/controllers/member_card_controller.dart';
import 'package:isocare/config.dart';
import 'package:isocare/helpers/utils.dart';
import 'package:isocare/models/user_model.dart';

class MemberCard extends GetView<MemberCardController> {
  MemberCard({Key? key}) : super(key: key);

  final memberCard = Get.put(MemberCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        title: const Text(
          'Kartu Peserta',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Padding(
                  padding: EdgeInsets.all(
                    Config.screenWidth! * 0.01,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            Config.screenWidth! * 0.02,
                          ),
                          child: const Text('Tampak Depan'),
                        ),
                      ),
                      Card(
                        color: Colors.teal[50],
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: Config.screenWidth! * 0.02,
                                bottom: Config.screenWidth! * 0.02,
                                left: Config.screenWidth! * 0.03,
                                right: Config.screenWidth! * 0.03,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/insurance-logo.png',
                                        width: Config.screenWidth! * 0.35,
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/logo.png',
                                        width: Config.screenWidth! * 0.35,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.04,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'No. Kartu',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${memberCard.cardNumber}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'No. ID Peserta',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${memberCard.memberId}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Nama Peserta',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${memberCard.memberName}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Tanggal Lahir',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${Utils.localeDate(memberCard.birthDate.toString())}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Jenis Kelamin',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${UserModel.convertGender(memberCard.gender)}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Perusahaan',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${memberCard.companyId}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Berlaku s/d',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          ': ${Utils.localeDate(memberCard.endPolicyDate.toString())}',
                                          style: TextStyle(
                                            fontSize:
                                                Config.screenWidth! * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Config.screenHeight! * 0.01,
                            ),
                            Container(
                              width: Config.screenWidth! * 1,
                              decoration: const BoxDecoration(
                                color: Color(0xFF7986CB),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.0),
                                  bottomRight: Radius.circular(2.0),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Config.screenWidth! * 0.01),
                                child: Text(
                                  "Perhatian: Gunakan kartu ini dengan menunjukkan kartu identitas yang sah. \n Hanya untuk peserta yang tercantum datanya di atas",
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.03,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Config.screenHeight! * 0.02,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            Config.screenWidth! * 0.02,
                          ),
                          child: const Text('Tampak Belakang'),
                        ),
                      ),
                      Card(
                        color: Colors.teal[50],
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: Config.screenWidth! * 0.02,
                                bottom: Config.screenWidth! * 0.02,
                                left: Config.screenWidth! * 0.03,
                                right: Config.screenWidth! * 0.03,
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    width: Config.screenWidth! * 0.35,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Config.screenHeight! * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: Config.screenWidth! * 0.05,
                                right: Config.screenWidth! * 0.05,
                              ),
                              child: Table(
                                border: TableBorder.all(),
                                children: [
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Konsultasi Dokter Umum',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Ya',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Obat-obatan',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Ya',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Tindakan Medis Sederhana',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Ya',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Biaya Administrasi',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Ya',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Tes Diagnostik',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                              Config.screenWidth! * 0.01,
                                            ),
                                            child: Text(
                                              'Konfirmasi',
                                              style: TextStyle(
                                                fontSize:
                                                    Config.screenWidth! * 0.035,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Config.screenHeight! * 0.02,
                            ),
                            Container(
                              width: Config.screenWidth! * 1,
                              decoration: const BoxDecoration(
                                color: Color(0xFF7986CB),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2.0),
                                  bottomRight: Radius.circular(2.0),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Config.screenWidth! * 0.01),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/ojk.png',
                                      width: Config.screenWidth! * 0.2,
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/layanan-bebas-pulsa.png',
                                      width: Config.screenWidth! * 0.5,
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/mari-berasuransi.png',
                                      width: Config.screenWidth! * 0.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Config.screenHeight! * 0.02,
          ),
        ],
      ),
    );
  }
}
