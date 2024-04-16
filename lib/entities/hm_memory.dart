class HmMemory implements Comparable<HmMemory> {
  DateTime date;
  String fromLang;
  String toLang;
  String author = "";

  HmMemory(this.date, this.fromLang, this.toLang);

  Map<String, Object> toMap() {
    return {
      'date': date.toString(),
      'fromLang': fromLang,
      'toLang': toLang,
      'author': author,
    };
  }

  factory HmMemory.fromMap(Map<String, dynamic> map) {
    HmMemory hm = HmMemory(
      DateTime.parse(map['date']),
      map['fromLang'],
      map['toLang'],
    );
    hm.author = map['author'];
    return hm;
  }

  @override
  int compareTo(HmMemory other) {
    if (date.compareTo(other.date) == -1) {
      return 1;
    } else if (date.compareTo(other.date) == 0) {
      return 0;
    } else {
      return -1;
    }
  }

}