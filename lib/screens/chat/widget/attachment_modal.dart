import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../helpers/ui_data.dart';
import '../../../../styles/color.dart';
import '../../../../styles/text_style.dart';

class AttachmentModal {
  final BuildContext context;

  AttachmentModal({required this.context});

  Future<File?> getFile() {
    final wait = Completer<File?>();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Camera',
                  style: TextStyles.sendbirdBody1OnLight1,
                ),
                trailing: const ImageIcon(
                  AssetImage('assets/iconCamera@3x.png'),
                  color: SBColors.primary_300,
                ),
                onTap: () async {
                  final statusCamera = await Permission.camera.request();
                  if (statusCamera == PermissionStatus.granted) {
                    Navigator.pop(context);
                    final res = await _showPicker(ImageSource.camera);
                    wait.complete(res);
                  } else if (statusCamera ==
                      PermissionStatus.permanentlyDenied) {
                    Navigator.pop(context);
                    wait.complete(null);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Txt('Akses Kamera', TextStyle()),
                        content: const Txt(
                            'Aplikasi ini membutuhkan akses ke kamera untuk mengambil gambar',
                            TextStyle()),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Txt('Tolak', TextStyle()),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                              child: Txt('Pengaturan', TextStyle()),
                              onPressed: () {
                                Navigator.of(context).pop();
                                openAppSettings();
                              }),
                        ],
                      ),
                    );
                  }
                },
              ),
              ListTile(
                  title: const Text(
                    'Galeri',
                    style: TextStyles.sendbirdBody1OnLight1,
                  ),
                  trailing: const ImageIcon(
                    AssetImage('assets/iconPhoto@3x.png'),
                    color: SBColors.primary_300,
                  ),
                  onTap: () async {
                    var statusGallery;
                    if (Platform.isAndroid) {
                      statusGallery = await Permission.storage.request();
                      if (statusGallery == PermissionStatus.granted) {
                        Navigator.pop(context);
                        final res = await _showPicker(ImageSource.gallery);
                        wait.complete(res);
                      } else if (statusGallery ==
                          PermissionStatus.permanentlyDenied) {
                        Navigator.pop(context);
                        wait.complete(null);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Txt('Akses Galeri', TextStyle()),
                                  content: Txt(
                                      'Aplikasi ini membutuhkan akses ke Galeri untuk mengambil gambar',
                                      TextStyle()),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text('Tolak'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                        child: Txt('Pengaturan', TextStyle()),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          openAppSettings();
                                        }),
                                  ],
                                ));
                      }
                    } else if (Platform.isIOS) {
                      statusGallery = await Permission.photos.request();
                      if (statusGallery == PermissionStatus.granted) {
                        Navigator.pop(context);
                        final res = await _showPicker(ImageSource.gallery);
                        wait.complete(res);
                      } else if (statusGallery ==
                          PermissionStatus.permanentlyDenied) {
                        Navigator.pop(context);
                        wait.complete(null);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: Txt('Akses Galeri', TextStyle()),
                            content: Txt(
                                'Aplikasi ini membutuhkan akses ke Galeri untuk mengambil gambar',
                                TextStyle()),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('Tolak'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              CupertinoDialogAction(
                                  child: Txt('Pengaturan', TextStyle()),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    openAppSettings();
                                  }),
                            ],
                          ),
                        );
                      }
                    }
                  }),
              ListTile(
                title: const Text('Batal'),
                onTap: () {
                  Navigator.pop(context);
                  wait.complete(null);
                },
              ),
            ],
          ));
        });

    return wait.future;
  }

  final picker = ImagePicker();

  Future<File?> _showPicker(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 25);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
