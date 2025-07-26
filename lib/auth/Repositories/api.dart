import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

final String url = 'https://api.nekosapi.com/v4/images/random';

Future<String?> getRandomImage() async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Decode as List
      List<dynamic> jsonList = json.decode(response.body);

      // Get the first image URL
      if (jsonList.isNotEmpty) {
        String imageUrl = jsonList[0]['url'];
        print(imageUrl);
        return imageUrl;
      } else {
        Fluttertoast.showToast(msg: 'No images returned.');
      }
    } else {
      Fluttertoast.showToast(msg: 'Request failed: ${response.statusCode}');
    }
  } catch (e) {
    Fluttertoast.showToast(msg: 'Error: $e');
  }

  return null;
}
