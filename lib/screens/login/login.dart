// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:isocare/config.dart';
import 'package:isocare/bindings/clinic_search_binding.dart';
import 'package:isocare/bindings/clinic_nearby_binding.dart';
import '../../controllers/auth_controller.dart';
import '../clinic/clinic_search.dart';
import '../clinic/clinic_nearby.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _hasCallSupport = false;
  Future<void>? launched;
  final _phone = '08001200654';
  final _email = 'cm@isomedik.com';
  final auth = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: Config.screenHeight! * 0.035),
        Text(
          "Masuk",
          style: TextStyle(
            fontSize: Config.screenWidth! * 0.07,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.01),
        Text(
          "Masukkan No Kartu Isomedik dan Kata Sandi Anda.",
          style: TextStyle(
            fontSize: Config.screenWidth! * 0.035,
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.015),
        TextField(
          controller: auth.usernameController,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          decoration: const InputDecoration(
            labelText: "No Kartu Isomedik",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.015),
        TextField(
          controller: auth.passwordController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Kata Sandi",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.015),
        ElevatedButton.icon(
          onPressed: () => auth.login(
            auth.usernameController.text,
            auth.passwordController.text,
          ),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
          ),
          icon: const Icon(Icons.login),
          label: const Text("Masuk"),
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        Text(
          "Klinik",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Config.screenWidth! * 0.04,
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Config.screenWidth! * 0.45,
              height: Config.screenWidth! * 0.2,
              child: ElevatedButton.icon(
                onPressed: () => {
                  Get.to(
                    () => ClinicNearby(),
                    binding: ClinicNearbyBinding(),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  primary: kInfoColor,
                ),
                icon: const Icon(Icons.location_on),
                label: const Text('Klinik Terdekat'),
              ),
            ),
            SizedBox(
              width: Config.screenWidth! * 0.45,
              height: Config.screenWidth! * 0.2,
              child: ElevatedButton.icon(
                onPressed: () => {
                  Get.to(
                    () => ClinicSearch(),
                    binding: ClinicSearchBinding(),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  primary: kInfoColor,
                ),
                icon: const Icon(Icons.search),
                label: const Text('Pencarian Klinik'),
              ),
            ),
          ],
        ),
        SizedBox(height: Config.screenHeight! * 0.03),
        Text(
          "Layanan",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Config.screenWidth! * 0.04,
          ),
        ),
        SizedBox(height: Config.screenHeight! * 0.01),
        ElevatedButton.icon(
          onPressed: _hasCallSupport
              ? () => setState(() {
                    launched = _makePhoneCall(_phone);
                  })
              : null,
          style: ElevatedButton.styleFrom(
            primary: kErrorColor,
          ),
          icon: const Icon(Icons.phone),
          label: _hasCallSupport
              ? const Text('Layanan 24 Jam Bebas Pulsa')
              : const Text('Layanan Tidak Tersedia'),
        ),
        SizedBox(height: Config.screenHeight! * 0.01),
        ElevatedButton.icon(
          onPressed: () => setState(() {
            launched = _sendEmail(_email);
          }),
          style: ElevatedButton.styleFrom(
            primary: kWarningColor,
          ),
          icon: const Icon(Icons.email),
          label: const Text('Layanan Email'),
        ),
      ],
    );
  }
}
