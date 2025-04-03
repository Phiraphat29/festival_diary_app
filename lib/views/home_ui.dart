import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/user.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  // สร้างตัวแปรรับค่าจากหน้า Login
  User? user;

  // สร้าง constructor รับค่าจากหน้า Login
  HomeUI({super.key, this.user});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            widget.user!.userImage! == ''
                ? Image.asset(
                  'assets/images/fest1.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                : Image.network(
                  '$baseUrl/${widget.user!.userImage!}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
            SizedBox(height: 60),
            Text(
              widget.user!.userFullname!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
