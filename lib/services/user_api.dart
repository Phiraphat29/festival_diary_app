//user_api.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';

import '../model/user.dart';

class UserApi {
  // สร้างออปเจคต์ dio เพื่อใช้เป็นตัวติดต่อกับ API
  final Dio dio = Dio();

  // สร้างฟังก์ชั่นสำหรับเรียกใช้ API ลงทะเบียน (เพิ่มข้อมูล User)
  Future<bool> registerUser(User user, File? userFile) async {
    try {
      // เอาข้อมูลใส่ Formdata
      final formdata = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      // เอาข้อมูล formdata ส่งไปที่ API ตาม Endpoint ที่ทำไว้
      final responseData = await dio.post(
        '$baseUrl/user/',
        data: formdata,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      // หลังจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: ${e}');
      return false;
    }
  }

  // สร้าง method เรียกใช้ API ให้เอาชื่อผู้ใช้รหัสผ่านไปตรวจสอบ
  Future<User> checkLogin(User user) async {
    try {
      final responseData = await dio.get(
        '$baseUrl/user/${user.userName}/${user.userPassword}',
      );
      // ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        // ถ้าสำเร็จให้แปลงข้อมูลที่ได้เป็น User
        return User.fromJson(responseData.data['info']);
      } else {
        return User();
      }
    } catch (e) {
      print('Error: ${e}');
      return User();
    }
  }

  // สร้าง method เรียกใช้ API แก้ไขข้อมูล User
  Future<User> updateUser(User user, File? userFile) async {
    try {
      // เอาข้อมูลใส่ Formdata
      final formdata = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if (userFile != null)
          'userImage': await MultipartFile.fromFile(
            userFile.path,
            filename: userFile.path.split('/').last,
            contentType: DioMediaType('image', userFile.path.split('.').last),
          ),
      });

      // เอาข้อมูล formdata ส่งไปที่ API ตาม Endpoint ที่ทำไว้
      final responseData = await dio.put(
        '$baseUrl/user/${user.userID}',
        data: formdata,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      // หลังจากทำงานเสร็จ ณ ที่นี้ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        return User.fromJson(responseData.data['info']);
      } else {
        return User();
      }
    } catch (e) {
      print('Error: ${e}');
      return User();
    }
  }
}
