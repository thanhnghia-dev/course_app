class ImageModel {
  final int id;
  final String name;
  final String url;

  ImageModel({
    required this.id,
    required this.url,
    required this.name,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'name': name,
    };
  }
  
  factory ImageModel.empty() {
    return ImageModel(id: 0, url: '', name: '');
  }
}