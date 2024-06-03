// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:isocare/controllers/clinic_search_controller.dart';
import 'package:isocare/config.dart';
import 'package:isocare/helpers/utils.dart';

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

Future<void> _openMaps(String lat, String long) async {
  final uri = "https://www.google.com/maps?q=" + lat + "," + long;
  await launch(uri.toString());
}

class ClinicSearch extends GetView<ClinicSearchController> {
  ClinicSearch({Key? key}) : super(key: key);

  final clinic = Get.find<ClinicSearchController>();

  TextEditingController keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        title: const Text(
          'Pencarian Klinik',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  Config.screenWidth! * 0.04,
                ),
                child: TextField(
                  controller: keywordController,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Ketikkan kata kunci",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => clinic.search(
                        keywordController.text,
                      ),
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: controller.obx(
              (data) => (data == null)
                  ? const Center(
                      child: Text('Kosong'),
                    )
                  : Center(
                      child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.all(
                                Config.screenWidth! * 0.04,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['PROVIDERNAME'],
                                    style: TextStyle(
                                      fontSize: Config.screenWidth! * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.02,
                                  ),
                                  Text(
                                    data[index]['BUILDING'],
                                    style: TextStyle(
                                      fontSize: Config.screenWidth! * 0.035,
                                    ),
                                  ),
                                  Text(
                                    data[index]['ZIPCODE'],
                                    style: TextStyle(
                                      fontSize: Config.screenWidth! * 0.035,
                                    ),
                                  ),
                                  if (data[index]['PHONE1'] != '')
                                    Text(
                                      data[index]['PHONE1'],
                                      style: TextStyle(
                                        fontSize: Config.screenWidth! * 0.035,
                                      ),
                                    ),
                                  if (data[index]['PHONE2'] != '')
                                    Text(
                                      data[index]['PHONE2'],
                                      style: TextStyle(
                                        fontSize: Config.screenWidth! * 0.035,
                                      ),
                                    ),
                                  if (data[index]['OperationalHour'] != '')
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Config.screenWidth! * 0.04,
                                      ),
                                      child: Text(
                                        Utils.replaceAsterisktoBreak(
                                            data[index]['OperationalHour']),
                                        style: TextStyle(
                                          fontSize: Config.screenWidth! * 0.035,
                                        ),
                                      ),
                                    ),
                                  if (data[index]['DoctorSchedule'] != '')
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Config.screenWidth! * 0.04,
                                      ),
                                      child: Text(
                                        Utils.replaceAsterisktoBreak(
                                            data[index]['DoctorSchedule']),
                                        style: TextStyle(
                                          fontSize: Config.screenWidth! * 0.035,
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Config.screenWidth! * 0.04,
                                    ),
                                    child: Text(
                                      'Diperbaharui: ' +
                                          Utils.localeDate(data[index][
                                                  'LastUpdateOprHourAndDocSchedule'])
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: Config.screenWidth! * 0.035,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Config.screenHeight! * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () => _makePhoneCall(
                                            data[index]['PHONE1']),
                                        style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Icon(Icons.phone),
                                      ),
                                      SizedBox(
                                        width: Config.screenWidth! * 0.02,
                                      ),
                                      ElevatedButton(
                                        onPressed: () => _openMaps(
                                            data[index]['LATITUDE'].toString(),
                                            data[index]['LONGITUDE']
                                                .toString()),
                                        style: ElevatedButton.styleFrom(
                                          primary: kErrorColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Icon(Icons.location_on),
                                      ),
                                      SizedBox(
                                        width: Config.screenWidth! * 0.02,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
