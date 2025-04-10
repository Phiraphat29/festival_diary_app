import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/user.dart';
import 'package:festival_diary_app/views/add_fest_ui.dart';
import 'package:festival_diary_app/views/login_ui.dart';
import 'package:festival_diary_app/views/user_ui.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginUI()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Column(
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
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
            SizedBox(height: 60),
            Text(
              widget.user!.userFullname!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserUI(user: widget.user),
                  ),
                ).then((value) {
                  setState(() {
                    widget.user = value;
                  });
                });
              },
              child: Text(
                '(Edit Profile)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(mainColor),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(mainColor),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFestUI(userID: widget.user!.userID!),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Festival"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
