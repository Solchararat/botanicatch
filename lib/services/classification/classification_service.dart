import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClassificationService {
  final String? endpointUrl;
  static ClassificationService? _instance;

  factory ClassificationService({required String endpointUrl}) {
    if (_instance == null || _instance!.endpointUrl != endpointUrl) {
      _instance = ClassificationService._internal(endpointUrl: endpointUrl);
    }
    return _instance!;
  }
  ClassificationService._internal({required this.endpointUrl});

  Future processClassification({
    required String base64Image,
  }) async {
    try {
      final response = await http.post(Uri.parse(endpointUrl!),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "image": base64Image,
          }));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            "Classification request failed: ${response.statusCode}");
      }
    } catch (e) {
      log("Classification error: $e");
    }
  }
}
