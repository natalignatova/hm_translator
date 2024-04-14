import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchYT {
  final String apiKey = 'AIzaSyCVyyCkPD2W8ZqMxOWQ36q4NJ2fcguhZZg';
  String searchQuery;

  SearchYT({required this.searchQuery});

  Future<List<String>> fetchVideoIds(String searchQuery) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=$searchQuery&type=video&key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<String> videoIds = [];
      for (var item in data['items']) {
        videoIds.add(item['id']['videoId']);
      }
      return videoIds;
    } else {
      throw Exception('Failed to load video');
    }
  }
}