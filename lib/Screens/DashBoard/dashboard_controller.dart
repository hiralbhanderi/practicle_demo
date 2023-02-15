import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class DashBoardController extends GetxController {
  TextEditingController addTextController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  RxString userEnterText = ''.obs;
  Rx<Offset> offsetValue = Offset.zero.obs;

  List<TextEditingController> otherTextController = <TextEditingController>[];
  RxList<double> scaleFactorListValue = <double>[].obs;
  RxList<Offset> offSetListData = <Offset>[].obs;

  RxString fileImagePath = ''.obs;
  File? selectedImage;
  RxInt selectedIndex = 0.obs;
  RxDouble baseScaleFactor = 1.0.obs;

  Future<void> pickImage() async {
    try {
      var result = (await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      ));

      if (result != null) {
        fileImagePath.value = result.files.single.path.toString();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Please select image')));
      }
    } catch (e, st) {
      print("error---->$e ----$st}");
    }
  }

  Future<void> saveImage({required BuildContext context}) async {
    await screenshotController.capture(delay: const Duration(microseconds: 50)).then(
          (saveImageValue) async {
        if (saveImageValue != null) {
          const screenshotDirectory = '/storage/emulated/0/DCIM/Screenshots';
          final imagePath =
          await File('$screenshotDirectory/image_${DateTime.now().millisecond}.png').create(recursive: true);

          await imagePath.writeAsBytes(saveImageValue);

          fileImagePath.value = "";
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Image saved successfully')));
        }
      },
    ).catchError((onError) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('error in saving image!')));
    });
  }
}
