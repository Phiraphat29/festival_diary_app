import 'dart:io';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  // สร้างตัวแปรควบคุม Textfield
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // สร้างตัวแปรดปิดปิดตากับช่องรหัสผ่าน
  bool isObscure = true;

  // ตัวแปรเก็บรูปถ่าย
  File? userFile;

  // ฟังก์ชั่นเปิดกล้องถ่ายรูป
  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      userFile = File(image.path);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(mainUserColor),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          'Festival Diary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 20),
                  Text(
                    'ลงทะเบียน',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      openCamera();
                    },
                    child:
                        userFile == null
                            ? Icon(Icons.person_add_alt_1_sharp, size: 125)
                            : Image.file(
                              userFile!,
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อ-นามสกุล',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label_important_outline),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รหัสผ่าน',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure == true
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainUserColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ลงทะเบียน',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // ส่งข้อมูลไปบันทึกที่ฐานข้อมูลผ่าน Backend ที่สร้างไว้
                      // Validate
                      if (fullNameController.text.trim().isEmpty) {
                        showWarningSnackBar('กรุณากรอกชื่อ-นามสกุล');
                      } else if (usernameController.text.trim().isEmpty) {
                        showWarningSnackBar('กรุณากรอกชื่อผู้ใช้');
                      } else if (passwordController.text.trim().isEmpty) {
                        showWarningSnackBar('กรุณากรอกรหัสผ่าน');
                      } else {
                        // แพ็คข้อมูลแล้วส่งผ่าน API ไปยังฐานข้อมูล
                        User user = User(
                          userFullname: fullNameController.text,
                          userName: usernameController.text,
                          userPassword: passwordController.text,
                        );
                        // ส่งข้อมูลผ่าน API ไปยังฐานข้อมูล
                        if (await UserApi().registerUser(user, userFile)) {
                          showCompleteSnackBar('ลงทะเบียนสำเร็จ');
                        } else {
                          showWarningSnackBar('ลงทะเบียนไม่สำเร็จ');
                        }
                      }
                    },
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
