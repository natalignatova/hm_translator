import 'package:flutter/material.dart';
import 'package:hm/widgets/youtube_widget.dart';
import 'package:hm/functions/get_random_int_function.dart';

Widget buildFutureBuilder(BuildContext context, AsyncSnapshot<List<String>> snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
      child: CircularProgressIndicator(),
    );
  } else if (snapshot.hasError) {
    return Center(
      child: Text('Error: ${snapshot.error}'),
    );
  } else {
    List<String>? videoIds = snapshot.data;
    int randomInt = getRandomIndex(videoIds);
    if (videoIds != null && videoIds.isNotEmpty && videoIds[0] != null) {
      return Container(
        width: double.infinity,
        child: ShowMustGoOnWidget(videoId: videoIds[randomInt]),
      );
    } else {
      return Center(
        child: Text('No videos found'),
      );
    }
  }
}