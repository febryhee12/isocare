import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/config.dart';
import 'package:isocare/controllers/auth_controller.dart';
import 'package:isocare/helpers/utils.dart';
import 'package:isocare/bindings/benefit_binding.dart';
import 'package:isocare/bindings/member_card_binding.dart';
import 'package:isocare/models/user_model.dart';
import 'package:isocare/screens/root.dart';
import '../benefit/benefit.dart';
import '../member_card/member_card.dart';

Future _refreshData() async {
  Get.off(() => Root());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: GetBuilder<AuthController>(
            builder: (_authController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Config.screenHeight! * 0.025),
                  Expanded(
                    flex: 8,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Profil Pengguna',
                              style: TextStyle(
                                fontSize: Config.screenWidth! * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: () => _authController.logout(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(Icons.logout),
                              label: const Text("Logout"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Config.screenHeight! * 0.02,
                        ),
                        Card(
                          elevation: 8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  _authController.user['memberName'].toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  _authController.user['companyId'].toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Config.screenWidth! * 0.04,
                                ),
                                child: Text(
                                  _authController.user['memberId'].toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Config.screenWidth! * 0.04,
                                ),
                                child: Text(
                                  'Tanggal Lahir: ' +
                                      Utils.localeDate(
                                              _authController.user['birthDate'])
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Config.screenWidth! * 0.04,
                                ),
                                child: Text(
                                  'Jenis Kelamin: ' +
                                      UserModel.convertGender(
                                              _authController.user['gender'])
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: Config.screenHeight! * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Config.screenWidth! * 0.04,
                                ),
                                child: Text(
                                  'Periode Polis: \n' +
                                      Utils.localeDate(_authController
                                              .user['effectiveDate'])
                                          .toString() +
                                      ' s.d ' +
                                      Utils.localeDate(_authController
                                              .user['endPolicyDate'])
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: Config.screenWidth! * 0.035,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: Config.screenHeight! * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton.icon(
                                    onPressed: () => {
                                      Get.to(
                                        () => Benefit(),
                                        binding: BenefitBinding(),
                                        arguments: [
                                          {
                                            "memberId": _authController
                                                .user['memberId'],
                                            "memberName": _authController
                                                .user['memberName'],
                                          },
                                        ],
                                      ),
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kInfoColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    icon: const Icon(Icons.verified_user),
                                    label: const Text("Benefit"),
                                  ),
                                  SizedBox(
                                    width: Config.screenWidth! * 0.02,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () => {
                                      Get.to(
                                        () => MemberCard(),
                                        binding: MemberCardBinding(),
                                        arguments: [
                                          {
                                            "cardNumber": _authController
                                                .user['memberId'],
                                            "memberId": _authController
                                                .user['isoMemberId'],
                                            "memberName": _authController
                                                .user['memberName'],
                                            "birthDate": _authController
                                                .user['birthDate'],
                                            "gender":
                                                _authController.user['gender'],
                                            "companyId": _authController
                                                .user['companyId'],
                                            "endPolicyDate": _authController
                                                .user['endPolicyDate'],
                                          },
                                        ],
                                      ),
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kInfoColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.credit_card,
                                    ),
                                    label: const Text("Kartu"),
                                  ),
                                  SizedBox(
                                    width: Config.screenWidth! * 0.02,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Config.screenHeight! * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Config.screenHeight! * 0.04,
                        ),
                        Text(
                          'Pertanggungan',
                          style: TextStyle(
                            fontSize: Config.screenWidth! * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: (_authController.dependents.isEmpty)
                              ? Padding(
                                  padding: EdgeInsets.all(
                                    Config.screenWidth! * 0.05,
                                  ),
                                  child: const Text('Tidak ada tanggungan'),
                                )
                              : ListView.builder(
                                  itemCount: _authController.dependents.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: Config.screenHeight! * 0.02,
                                        ),
                                        Card(
                                          elevation: 8,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  _authController
                                                      .dependents[index]
                                                          ['MemberName']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  _authController
                                                      .dependents[index]
                                                          ['BranchCode']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Config.screenWidth! *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  _authController
                                                      .dependents[index]
                                                          ['IsoMedikMemberId']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Config.screenWidth! *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  'Tanggal Lahir: ' +
                                                      Utils.localeDate(
                                                              _authController
                                                                          .dependents[
                                                                      index][
                                                                  'DateOfBirth'])
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Config.screenWidth! *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  'Jenis Kelamin: ' +
                                                      UserModel.convertGender(
                                                              _authController
                                                                      .dependents[
                                                                  index]['Gender'])
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Config.screenWidth! *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  'Hubungan: ' +
                                                      UserModel.convertRelationship(
                                                              _authController
                                                                          .dependents[
                                                                      index][
                                                                  'Relationship'])
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Config.screenHeight! * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Config.screenWidth! *
                                                      0.04,
                                                ),
                                                child: Text(
                                                  'Periode Polis: \n' +
                                                      Utils.localeDate(_authController
                                                                      .dependents[
                                                                  index]
                                                              ['EffectiveDate'])
                                                          .toString() +
                                                      ' s.d ' +
                                                      Utils.localeDate(_authController
                                                                      .dependents[
                                                                  index]
                                                              ['EndPolicyDate'])
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        Config.screenWidth! *
                                                            0.035,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Config.screenHeight! * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ElevatedButton.icon(
                                                    onPressed: () => {
                                                      Get.to(
                                                        () => Benefit(),
                                                        binding:
                                                            BenefitBinding(),
                                                        arguments: [
                                                          {
                                                            "memberId": _authController
                                                                        .dependents[
                                                                    index][
                                                                'IsoMedikMemberId'],
                                                            "memberName":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'MemberName'],
                                                          },
                                                        ],
                                                      ),
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          kInfoColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                    ),
                                                    icon: const Icon(
                                                        Icons.verified_user),
                                                    label:
                                                        const Text("Benefit"),
                                                  ),
                                                  SizedBox(
                                                    width: Config.screenWidth! *
                                                        0.02,
                                                  ),
                                                  ElevatedButton.icon(
                                                    onPressed: () => {
                                                      Get.to(
                                                        () => MemberCard(),
                                                        binding:
                                                            MemberCardBinding(),
                                                        arguments: [
                                                          {
                                                            "cardNumber":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'MemberId'],
                                                            "memberId": _authController
                                                                        .dependents[
                                                                    index][
                                                                'IsoMedikMemberId'],
                                                            "memberName":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'MemberName'],
                                                            "birthDate":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'DateOfBirth'],
                                                            "gender": _authController
                                                                    .dependents[
                                                                index]['Gender'],
                                                            "companyId":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'BranchCode'],
                                                            "endPolicyDate":
                                                                _authController
                                                                            .dependents[
                                                                        index][
                                                                    'EndPolicyDate'],
                                                          },
                                                        ],
                                                      ),
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          kInfoColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.credit_card,
                                                    ),
                                                    label: const Text("Kartu"),
                                                  ),
                                                  SizedBox(
                                                    width: Config.screenWidth! *
                                                        0.02,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    Config.screenHeight! * 0.01,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Config.screenHeight! * 0.02,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
