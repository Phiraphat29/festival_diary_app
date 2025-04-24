import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/constants/color_constant.dart';
import 'package:festival_diary_app/model/fest.dart';
import 'package:festival_diary_app/model/user.dart';
import 'package:festival_diary_app/services/fest_api.dart';
import 'package:festival_diary_app/views/add_fest_ui.dart';
import 'package:festival_diary_app/views/edit_del_fest_ui.dart';
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

// -------------------------------------------

class _HomeUIState extends State<HomeUI> {
  // สร้างตัวแปรเก็บข้อมูล fest ที่ได้มาจากการดึงข้อมูลจากฐานข้อมูล API
  late Future<List<Fest>> festAllData;

  // สร้าง method ดึงข้อมูล fest ทั้งหมดของผู้ใช้งานที่ Login เข้ามาจาก API ที่สร้างไว้
  Future<List<Fest>> getAllFestByUserFromHome() async {
    // เรียกใช้ method
    final festData = await FestApi().getAllFestByUser(widget.user!.userID!);
    return festData;
  }

  @override
  void initState() {
    // รัน method ทันทีที่หน้าจอ HomeUI แสดง
    festAllData = getAllFestByUserFromHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(mainUserColor),
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
                  color: Color(mainUserColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Fest>>(
                future: festAllData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('พบปัญหาในการทำงาน: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditDelFestUI(
                                        fest: snapshot.data![index],
                                      ),
                                ),
                              ).then((value) {
                                setState(() {
                                  festAllData = getAllFestByUserFromHome();
                                });
                              });
                            },
                            leading:
                                snapshot.data![index].festImage! == ''
                                    ? Image.asset(
                                      'assets/images/fest1.jpg',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                    : Image.network(
                                      '$baseUrl/${snapshot.data![index].festImage!}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                            title: Text(snapshot.data![index].festName!),
                            subtitle: Text(snapshot.data![index].festDetail!),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('ไม่มีข้อมูล'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(mainUserColor),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFestUI(userID: widget.user!.userID!),
            ),
          ).then((value) {
            setState(() {
              festAllData = getAllFestByUserFromHome();
            });
          });
        },
        icon: Icon(Icons.add),
        label: Text("Festival"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
