class elixirs {
  String id;
  String name;

  elixirs({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory elixirs.fromMap(Map<String, dynamic> map) {
    return elixirs(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
