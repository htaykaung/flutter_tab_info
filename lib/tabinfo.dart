class TabInfoModel {
  final String id;
  final String url;
  final int index;
  final String title;

  TabInfoModel({
    required this.id,
    required this.url,
    required this.index,
    required this.title,
  });

  factory TabInfoModel.fromJson(Map<String, dynamic> json) => TabInfoModel(
        id: json['id'].toString(),
        url: json['url'],
        index: json['index'],
        title: json['title'],
      );
}
