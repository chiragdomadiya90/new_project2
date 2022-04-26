import 'package:flutter/material.dart';
import 'package:new_project2/user_profile.dart';
import 'package:get/get.dart';
import 'contorller/bottom_controller.dart';
import 'home_scr.dart';

class Bottom_Nav extends StatefulWidget {
  @override
  State<Bottom_Nav> createState() => _Bottom_NavState();
}

BottomController bottomController = Get.put(BottomController());

class _Bottom_NavState extends State<Bottom_Nav> {
  List icon = [
    Icons.home,
    Icons.favorite,
    Icons.menu_book,
    Icons.notification_important_rounded,
    Icons.person,
  ];

  List scr = [
    Home(),
    Container(),
    Container(),
    Container(),
    User_Profile_Scr()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -3),
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 2)
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) => Obx(
              () => InkWell(
                onTap: () {
                  bottomController.selectedMenu(index);
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: bottomController.selectBottom.value == index
                      ? Color(0xff03cdcd)
                      : Colors.transparent,
                  child: Icon(
                    icon[index],
                    size: 28,
                    color: bottomController.selectBottom.value == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => scr[bottomController.selectBottom.value]),
    );
  }
}
