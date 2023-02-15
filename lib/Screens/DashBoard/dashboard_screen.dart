import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practicle/Screens/DashBoard/dashboard_controller.dart';
import 'package:flutter_practicle/Utils/assets_utils.dart';
import 'package:flutter_practicle/Utils/colorRes.dart';
import 'package:flutter_practicle/Utils/common_views/dragged_text_view.dart';
import 'package:flutter_practicle/Utils/strings_const.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatelessWidget {
  static const routeName = '/DashBoardScreen';

  DashBoardScreen({Key? key}) : super(key: key);
  final DashBoardController dashBoardController =
      Get.put(DashBoardController());



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Practical Demo',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.whiteColor),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: GestureDetector(
                  onTap: () {
                    if (dashBoardController.fileImagePath.value.isEmpty) {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(content: Text('Select image first')));
                    } else {
                      dashBoardController.saveImage(context: context);
                    }
                  },
                  child: Icon(
                    Icons.save_alt,
                    color: ColorRes.whiteColor,
                    size: 10.w,
                  )),
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => dashBoardController.fileImagePath.value.isNotEmpty
                    ? selectedImageView(
                        fileImagePath: dashBoardController.fileImagePath.value,
                      )
                    : Icon(Icons.photo,size: 50.w,color: ColorRes.blackColor.withOpacity(0.6),),
              ),
              SizedBox(
                height: 4.h,
              ),
              GestureDetector(
                onTap: () async {
                  await dashBoardController.pickImage();
                },
                child: Container(
                  height: 6.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: ColorRes.blueColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      StringsConst.addImage,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: ColorRes.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return dialogForAddText(
                    context,
                    userTextController: dashBoardController.addTextController,
                    addTextButton: () {
                      dashBoardController.userEnterText.value =
                          dashBoardController.addTextController.text;
                      dashBoardController.otherTextController.add(
                        TextEditingController(
                          text: dashBoardController.userEnterText.value,
                        ),
                      );
                      dashBoardController.scaleFactorListValue.add(
                        1.0
                      );
                      dashBoardController.addTextController.clear();
                      Get.back();
                    },
                  );
                });
          },
          child: Container(
            height: 50,
            width: 50,
            child: const Icon(
              Icons.add,
              color: ColorRes.whiteColor,
            ),
            decoration: const BoxDecoration(
              color: ColorRes.blueColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget dialogForAddText(
    BuildContext context, {
    VoidCallback? addTextButton,
    TextEditingController? userTextController,
  }) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: ColorRes.whiteColor,
      title: Text(
        StringsConst.addYourText,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: ColorRes.blackColor.withOpacity(0.7)),
      ),
      content: SizedBox(
        height: 12.w,
        width: double.infinity,
        child: TextField(
          controller: dashBoardController.addTextController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.only(top: 2.w, left: 4.w),
              hintText: StringsConst.enterYourText),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorRes.blueColor),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            StringsConst.cancel,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorRes.whiteColor),
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorRes.blueColor),
          onPressed: addTextButton,
          child: const Text(
            StringsConst.addText,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorRes.whiteColor),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
    );
  }

  Widget selectedImageView({String? fileImagePath}) {
    return Stack(
      children: [
        Screenshot(
          controller: dashBoardController.screenshotController,
          child: Stack(
            children: [
              Image.file(
                File(fileImagePath ?? ''),
                width: double.infinity,
                height: 400,
                fit: BoxFit.fill,
              ),
              DraggedTextView(),
            ],
          ),
        ),
      ],
    );
  }
}
