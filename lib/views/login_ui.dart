import 'dart:math';

import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/user.dart';
import 'package:festival_diary_app/services/user_api.dart';
import 'package:festival_diary_app/views/home_ui.dart';
import 'package:festival_diary_app/views/register_ui.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  // สร้างตัวแปรควบคุม Textfield
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // สร้างตัวแปรเปิดปิดตากับช่องรหัสผ่าน
  bool isObscure = true;

  // เมธอดแสดง snackbar เตือน
  void showWarningSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainColor),
        foregroundColor: Colors.white,
        centerTitle: true,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/fest1.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
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
                          isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mainColor),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // Validadte UI
                      if (usernameController.text.length == 0) {
                        showWarningSnackBar('กรุณากรอกชื่อผู้ใช้');
                      } else if (passwordController.text.length == 0) {
                        showWarningSnackBar('กรุณากรอกรหัสผ่าน');
                      } else {
                        // ส่งชื่อผู้ใช้และรหัสผ่านไปยัง API เพื่อตรวจสอบ
                        // แพ็กข้อมูลที่ต้องส่งไปให้กับ checkLogin()
                        User user = User(
                          userName: usernameController.text,
                          userPassword: passwordController.text,
                        );
                        // เรียกใช้ checkLogin() เพื่อส่งข้อมูลไปยัง API
                        user = await UserApi().checkLogin(user);
                        if (user.userID != null) {
                          // แปลว่าสำเร็จ เปิดไปหน้าจอ HomeUI
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeUI(user: user),
                            ),
                          );
                        } else {
                          // แปลว่าผิดพลาด
                          showWarningSnackBar(
                            'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง',
                          );
                        }
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ยังไม่มีบัญชี?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterUI(),
                            ),
                          );
                        },
                        child: Text(
                          'ลงทะเบียน',
                          style: TextStyle(color: Color(mainColor)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Copyright © 2025'),
                  Text('All rights reserved'),
                  Text('Created by Phiraphat DTI-SAU'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
