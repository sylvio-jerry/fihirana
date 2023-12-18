class Music {
  String? page;
  String? key;
  String? title;

  Music({this.page, this.key, this.title});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      page: json['page'],
      key: json['key'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['key'] = key;
    data['title'] = title;
    return data;
  }
}
