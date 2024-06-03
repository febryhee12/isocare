import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isocare/controllers/benefit_controller.dart';
import 'package:isocare/config.dart';
import 'package:intl/intl.dart';

class Benefit extends GetView<BenefitController> {
  Benefit({Key? key}) : super(key: key);

  final benefit = Get.put(BenefitController());
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        title: const Text(
          'Benefit Peserta',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Config.screenHeight! * 0.02,
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.all(
                Config.screenWidth! * 0.04,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${benefit.memberName}',
                    style: TextStyle(
                      fontSize: Config.screenWidth! * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${benefit.memberId}',
                    style: TextStyle(
                      fontSize: Config.screenWidth! * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Config.screenHeight! * 0.02,
          ),
          Expanded(
            child: controller.obx(
              (data) => Center(
                child: ListView.builder(
                  itemCount: data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                          Config.screenWidth! * 0.04,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data[index]['CoverageCode']}',
                              style: TextStyle(
                                fontSize: Config.screenWidth! * 0.035,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: Config.screenHeight! * 0.01,
                            ),
                            Text(
                              '${data[index]['ConditionDesc']}',
                              style: TextStyle(
                                fontSize: Config.screenWidth! * 0.035,
                              ),
                            ),
                            SizedBox(
                              height: Config.screenHeight! * 0.02,
                            ),
                            Text(
                              (data[index]['MaxValue'] == 999999999.00)
                                  ? 'FREE'
                                  : 'Rp. ${numberFormat.format(data[index]['MaxValue'])}',
                              style: TextStyle(
                                fontSize: Config.screenWidth! * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: Config.screenHeight! * 0.02,
          ),
        ],
      ),
    );
  }
}
