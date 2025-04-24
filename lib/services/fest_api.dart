import 'dart:io';

import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/model/fest.dart';

class FestApi {
  // สร้างออปเจคต์ dio เพื่อใช้เป็นตัวติดต่อกับ API
  final Dio dio = Dio();

  // สร้าง method เรียกใช้ API เพิ่มข้อมูล Fest
  Future<bool> insertFest(Fest fest, File? festFile) async {
    try {
      // เอาข้อมูลใส่ Formdata
      final formdata = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userID': fest.userID,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });

      // เอาข้อมูล formdata ส่งไป ที่ API ตาม Endpoint ที่ทำไว้
      final responseData = await dio.post(
        '$baseUrl/fest/',
        data: formdata,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      // ตรวจสอบผลการทำงานจาก responseData
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

  Future<List<Fest>> getAllFestByUser(int userID) async {
    try {
      final responseData = await dio.get('$baseUrl/fest/$userID');

      if (responseData.statusCode == 200) {
        return (responseData.data['info'] as List)
            .map((e) => Fest.fromJson(e))
            .toList();
      } else {
        return <Fest>[];
      }
    } catch (e) {
      print('Error: ${e}');
      return <Fest>[];
    }
  }

  // สร้าง method ลบข้อมูล festival
  Future<bool> deleteFest(int festID) async {
    try {
      final responseData = await dio.delete('$baseUrl/fest/$festID');

      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: ${e}');
      return false;
    }
  }

  Future<bool> updateFest(Fest fest, File? festFile) async {
    try {
      // เอาข้อมูลใส่ Formdata
      final formdata = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festState': fest.festState,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userID': fest.userID,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });

      // เอาข้อมูล formdata ส่งไป
      final responseData = await dio.put(
        '$baseUrl/fest/${fest.festID}',
        data: formdata,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      // ตรวจสอบผลการทำงานจาก responseData
      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: ${e}');
      return false;
    }
  }
}
