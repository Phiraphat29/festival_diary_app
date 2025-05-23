import 'dart:io';

import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/fest.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDelFestUI extends StatefulWidget {
  Fest? fest;
  EditDelFestUI({super.key, this.fest});

  @override
  State<EditDelFestUI> createState() => _EditDelFestUIState();
}

class _EditDelFestUIState extends State<EditDelFestUI> {
  // สร้างตัวควบคุม Textfield
  TextEditingController festNameController = TextEditingController();
  TextEditingController festDetailController = TextEditingController();
  TextEditingController festStateController = TextEditingController();
  TextEditingController festCostController = TextEditingController();
  TextEditingController festNumDayController = TextEditingController();

  // แสดง snackbar เตือน
  void showWarningSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  void showCompleteSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  // ตัวแปรเก็บรูปถ่าย
  File? festFile;

  // ฟังก์ชั่นเปิดกล้องถ่ายรูป
  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      festFile = File(image.path);
    });
  }

  @override
  void initState() {
    festNameController.text = widget.fest!.festName!;
    festDetailController.text = widget.fest!.festDetail!;
    festStateController.text = widget.fest!.festState!;
    festCostController.text = widget.fest!.festCost.toString();
    festNumDayController.text = widget.fest!.festNumDay.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainFestColor),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'รายละเอียด Festival Diary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'เพิ่มข้อมูล Festival',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child:
                        festFile == null
                            ? widget.fest!.festImage! == ''
                                ? Image.asset(
                                  'assets/images/fest1.jpg',
                                  width: 125,
                                  height: 125,
                                  fit: BoxFit.cover,
                                )
                                : Image.network(
                                  '$baseUrl/${widget.fest!.festImage!}',
                                  width: 125,
                                  height: 125,
                                  fit: BoxFit.cover,
                                )
                            : Image.file(
                              festFile!,
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อ Festival',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: festNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.festival_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รายละเอียด Festival',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: festDetailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.details_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'สถานที่ Festival',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: festStateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ค่าใช้จ่าย Festival',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: festCostController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'จำนวนวันงาน Festival',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: festNumDayController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range_outlined),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainFestColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'บันทึกแก้ไขงาน Festival',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // Validate
                      if (festNameController.text.trim().isEmpty) {
                        showWarningSnackBar('กรอกชื่อ Festival');
                      } else if (festDetailController.text.trim().isEmpty) {
                        showWarningSnackBar('กรอกรายละเอียด Festival');
                      } else if (festStateController.text.trim().isEmpty) {
                        showWarningSnackBar('กรอกสถานที่ Festival');
                      } else if (festCostController.text.trim().isEmpty) {
                        showWarningSnackBar('กรอกค่าใช้จ่าย Festival');
                      } else if (festNumDayController.text.trim().isEmpty) {
                        showWarningSnackBar('กรอกจำนวนงาน Festival');
                      } else {
                        // บันทึกข้อมูลลง Database
                        // แพ็คข้อมูล
                        Fest fest = Fest(
                          festName: festNameController.text.trim(),
                          festDetail: festDetailController.text.trim(),
                          festState: festStateController.text.trim(),
                          festCost: double.parse(
                            festCostController.text.trim(),
                          ),
                          festNumDay: int.parse(
                            festNumDayController.text.trim(),
                          ),
                          userID: widget.fest!.userID,
                          festID: widget.fest!.festID,
                        );
                        // ส่งข้อมูลผ่าน API ไปบันทึกลง DB
                        if (await FestApi().updateFest(fest, festFile)) {
                          showCompleteSnackBar('แก้ไขสำเร็จ');
                        } else {
                          showWarningSnackBar('แก้ไขไม่สำเร็จ');
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainUserColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ลบงาน Festival',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (await FestApi().deleteFest(widget.fest!.festID!)) {
                        showCompleteSnackBar('ลบงาน Festival สำเร็จ');
                        Navigator.pop(context);
                      } else {
                        showWarningSnackBar('ลบงาน Festival ไม่สำเร็จ');
                      }
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
