class Currency {
  final String name;
  final String key;

  Currency({
    required this.name,
    required this.key,
  });

  Currency.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        key = json['key'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'key': key,
      };
}
