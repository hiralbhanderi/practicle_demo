import 'package:flutter/material.dart';
import 'package:flutter_practicle/Screens/DashBoard/dashboard_controller.dart';
import 'package:flutter_practicle/Utils/colorRes.dart';
import 'package:get/get.dart';

class DraggedTextView extends StatelessWidget {
  DraggedTextView({Key? key}) : super(key: key);
  final DashBoardController dashBoardController = Get.find();

  @override
  Widget build(BuildContext context) {
    dashBoardController.offSetListData.add(Offset(80, 10));
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                for (var index = 0; index < dashBoardController.otherTextController.length; index++)
                  Obx(
                    () => Positioned(
                      left: dashBoardController.offSetListData[index].dx,
                      top: dashBoardController.offSetListData[index].dy,
                      child: GestureDetector(
                        onScaleStart: (details) {
                          dashBoardController.baseScaleFactor.value = dashBoardController.scaleFactorListValue[index];
                        },
                        onScaleUpdate: (details) {
                          dashBoardController.offSetListData[index] = Offset(
                              dashBoardController.offSetListData[index].dx + details.focalPointDelta.dx,
                              dashBoardController.offSetListData[index].dy + details.focalPointDelta.dy);
                          if (dashBoardController.selectedIndex.value == index) {
                            dashBoardController.scaleFactorListValue[index] =
                                dashBoardController.baseScaleFactor.value * details.scale;
                          }
                        },
                        onTap: () {
                          dashBoardController.selectedIndex.value = index;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          decoration: dashBoardController.selectedIndex.value == index
                              ? BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: ColorRes.greenAccentColor,
                                    width: 1,
                                  ),
                                )
                              : null,
                          child: Text(
                            dashBoardController.otherTextController[index].text,
                            textAlign: TextAlign.center,
                            textScaleFactor: dashBoardController.scaleFactorListValue[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 45,
                              color: ColorRes.redColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ), // child: Stack(
        ),
      ),
    );
  }
}
