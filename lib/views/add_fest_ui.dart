import 'dart:io';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFestUI extends StatefulWidget {
  int? userID;
  AddFestUI({super.key, this.userID});

  @override
  State<AddFestUI> createState() => _AddFestUIState();
}

class _AddFestUIState extends State<AddFestUI> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainFestColor),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'เพิ่ม Festival Diary',
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
                      openCamera();
                    },
                    child:
                        festFile == null
                            ? Icon(Icons.travel_explore_outlined, size: 125)
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
                      'บันทึกข้อมูล',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {},
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
