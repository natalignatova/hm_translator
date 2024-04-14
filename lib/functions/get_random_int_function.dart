import 'dart:math';

int getRandomIndex(List<String>? list) {
  if (list == null || list.isEmpty) {
    return 0;
  } else {
    return Random().nextInt(list.length);
  }
}
