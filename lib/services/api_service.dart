import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService._init();

  ApiService._init();

  // Host default:
  // - Android Emulator: 10.0.2.2
  // - Windows / Web: localhost
  // - HP Fisik: bisa diisi IP komputer (misal: 192.168.100.144)
  static String? customHost;

  String get baseUrl {
    if (customHost != null && customHost!.isNotEmpty) {
      return 'http://$customHost/kalanusa_api';
    }
    if (kIsWeb) {
      return 'http://localhost/kalanusa_api';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2/kalanusa_api';
    }
    return 'http://localhost/kalanusa_api';
  }

  // ===================================
  // CRUD DESTINASI (XAMPP MYSQL)
  // ===================================

  Future<List<Map<String, dynamic>>> getDestinasi() async {
    try {
      final uri = Uri.parse('$baseUrl/destinasi.php');
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body['status'] == 'success' && body['data'] != null) {
          final List list = body['data'];
          return list.map((item) => Map<String, dynamic>.from(item)).toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint('Error getDestinasi XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> tambahDestinasi(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl/destinasi.php');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error tambahDestinasi XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> updateDestinasi(int id, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl/destinasi.php?action=update&id=$id');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error updateDestinasi XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> hapusDestinasi(int id) async {
    try {
      final uri = Uri.parse('$baseUrl/destinasi.php?action=delete&id=$id');
      final response = await http.post(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error hapusDestinasi XAMPP: $e');
      rethrow;
    }
  }

  // ===================================
  // CRUD RENCANA PERJALANAN (XAMPP MYSQL)
  // ===================================

  Future<List<Map<String, dynamic>>> getRencana() async {
    try {
      final uri = Uri.parse('$baseUrl/rencana.php');
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body['status'] == 'success' && body['data'] != null) {
          final List list = body['data'];
          return list.map((item) => Map<String, dynamic>.from(item)).toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint('Error getRencana XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> tambahRencana(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl/rencana.php');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error tambahRencana XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> updateRencana(int id, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$baseUrl/rencana.php?action=update&id=$id');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error updateRencana XAMPP: $e');
      rethrow;
    }
  }

  Future<bool> hapusRencana(int id) async {
    try {
      final uri = Uri.parse('$baseUrl/rencana.php?action=delete&id=$id');
      final response = await http.post(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'] == 'success';
      }
      return false;
    } catch (e) {
      debugPrint('Error hapusRencana XAMPP: $e');
      rethrow;
    }
  }
}
