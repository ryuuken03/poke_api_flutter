class Default{
  String? name;
  String? url;
  Default({
    this.name,
    this.url,
  });
  factory Default.fromJson(Map<String, dynamic> json) {
    return Default(
      name: json["name"] as String?,
      url: json["url"] as String?,
    );
  }
}