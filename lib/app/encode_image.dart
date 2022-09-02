import 'dart:convert';
import 'package:http/http.dart';

Future<String> base64encodedImage(String url) async {
  final Response response = await get(Uri.parse(url));
  final String base64Data = base64Encode(response.bodyBytes);
  return base64Data;
}
